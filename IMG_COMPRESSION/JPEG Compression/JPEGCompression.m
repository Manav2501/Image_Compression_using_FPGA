function [c] = JPEGCompression(image)
%

image=imread('cameraman.tif'); 
A=image;
[height,width,depth]=size(A);
N=8; 
%limit height and width to multiples of 8
if mod(height,N)~=0
    height=floor(height/N)*N;
end
if mod(width,N)~=0
    width=floor(width/N)*N;
end
A1=A(1:height,1:width,:);
clear A
A=A1;
 if depth>1
     A=rgb2gray(A);
 end
 
 y=double(A); %convert
 order=[1   2   6   7  15  16  28  29
   3   5   8  14  17  27  30  43
   4   9  13  18  26  31  42  44
  10  12  19  25  32  41  45  54
  11  20  24  33  40  46  53  55
  21  23  34  39  47  52  56  61
  22  35  38  48  51  57  60  62
  36  37  49  50  58  59  63  64];

Q = [16 11 10 16 24 40 51 61; 
     12 12 14 19 26 58 60 55; 
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62;
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];

%QstepsY=Q;
Qscale=50;

if (Qscale < 50)
    S = 5000/Qscale;
else
    S = 200 - 2*Qscale;
end

QstepsY=floor((S * Q + 50) / 100);
QstepsY(QstepsY==0)=1;

Yy=zeros(N,N);
xqY=zeros(height,width);
%acBitsY=0;
%dcBitsY=0;

for m=1:N:height
    for n=1:N:width
        for i=1:8
            for j=1:8
                LevelShifted(i,j)=y(i+m-1,j+n-1)-128;
            %t=y(m:m+N-1,n:n+N-1)-128; %Level Shifting
            end
        end
        
        Yy=dct2(LevelShifted);%8x8 2D DCT block of image
        for i=1:8
            for j=1:8
            Quantized(i+m-1,j+n-1)=round(Yy(i,j)/QstepsY(i,j));
            end
        end
        %temp=floor(Yy./QstepsY); %Quantize the dct coefficients
        %calculate bits for DC difference
        %if n==1
        %    DC=temp(1,1)-DC;
        %    dctBitsY=dcBitsY+jpegDCbits(DC,'Y');
        %else
        %    DC=temp(1,1)-DC;
        %    dctBitsY=dcBitsY+jpegDCbits(DC,'Y');
        %    DC=temp(1,1);
        %end
        %calculate the bits for the AC coefficients
        
        %ACblkBits=jpegACBits(temp,'Y');
        %acBitsY=acBitsY+ACblkBits;
        %dequantize and idct the dct coefficients
        for i=1:8
            for j=1:8
                DQuantized(i,j)= Quantized(i+m-1,j+n-1)*QstepsY(i,j);
            end
        end
        IDCTized= idct2(DQuantized);
        for i=1:8
            for j=1:8
                Final(i+m-1,j+n-1)= round(IDCTized(i,j))+128;
            end
        end
%         %xqY(m:m+N-1,n:n+N-1)=idct2(temp .* (Qscale*QstepsY))+128;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [I,J]=size(image)
 training_set = double(image(:));
 training_set = reshape(training_set,I*J,1);
 PicLloyd = zeros(1,7);
 s = 7:-1:0
       len = 2.^s;
       [partition, codebook] = lloyds(training_set, len);
       [PicLloyd ,index] = imquantize(image,partition,codebook);
 figure, imshow(uint8(PicLloyd))
 figure; plot(PicLloyd); title('MSE of image quantized by Lloyds');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Quantized = im2col(Quantized, [8 8], 'distinct'); %breaking 8*8 blocks into columns
xb = size(Quantized,2);  %gives you total number of blocks
Quantized = Quantized(order,:); %reordering column elements
 
eob = max(Quantized(:)) + 1; %create an end of block symbol
r = zeros(numel(Quantized) + size(Quantized,2), 1); %create vector
count=0;
for j = 1:xb                   %find last non zero element
    i = find(Quantized(:,j),1,'last');
    if isempty(i)
        i=0;
    end
    p = count + 1;
    q = p + i;
    r(p:q) = [Quantized(1:i, j); eob];%truncate zeros and add eob and add to the output vector
    count = count + i + 1;
end
 
r((count+1):end) = []; %delete unused portion

c= matrixToHuffman(r);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


display('Root Mean Squared Error');
e=double(image)-double(uint8(Final));
[m,n]=size(e);
rmse=sqrt(sum(e(:).^2)/(m*n));

if rmse
    %form error histogram
    emax=max(abs(e(:)));
    [h,x]=hist(e(:),emax);
    if length(h)>=1
        %figure;
        %bar(x,h,'k');
        %scale the error imagae symmetrically and display 
        
        emax=emax/1;
        e=mat2gray(e,[-emax,emax]);
        figure;
        imshow(e);
    end
    
    emax=emax/1;
    e=mat2gray(e,[-emax,emax]);
    figure;
    imshow(e);
end
display(rmse);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%TotalBits=acBitsY+dcBitsY;
%figure, imshow(uint8(Final),[])
%title(['Compressed Image']);
subplot(1,2,1)
imshow(A)
title('Original Image')
subplot(1,2,2)
imshow(uint8(Final))
title('Compressed Image')
%subplot(2,2,3)
%imshow(e)
%title('Error')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% G = [ 1/sqrt(2), 1/sqrt(2), 1/sqrt(2), 1/sqrt(2), 1/sqrt(2), 1/sqrt(2), 1/sqrt(2), 1/sqrt(2)
%     cos(pi/16), cos(pi*3/16), cos(pi*5/16), cos(pi*7/16), cos(pi*9/16), cos(pi*11/16), cos(pi*13/16), cos(pi*15/16)
%     cos(pi*2/16), cos(pi*6/16), cos(pi*10/16), cos(pi*14/16), cos(pi*18/16), cos(pi*22/16), cos(pi*26/16), cos(pi*30/16)
%     cos(pi*3/16), cos(pi*9/16), cos(pi*15/16), cos(pi*21/16), cos(pi*27/16), cos(pi*33/16), cos(pi*39/16), cos(pi*45/16)
%     cos(pi*4/16), cos(pi*12/16),cos(pi*20/16), cos(pi*28/16),cos(pi*36/16), cos(pi*44/16),cos(pi*52/16), cos(pi*60/16)
%     cos(pi*5/16), cos(pi*15/16),cos(pi*25/16), cos(pi*35/16),cos(pi*45/16), cos(pi*55/16),cos(pi*65/16), cos(pi*75/16)
%     cos(pi*6/16), cos(pi*18/16),cos(pi*30/16), cos(pi*42/16),cos(pi*54/16), cos(pi*66/16),cos(pi*78/16), cos(pi*90/16)
%     cos(pi*7/16), cos(pi*21/16),cos(pi*35/16), cos(pi*49/16),cos(pi*63/16), cos(pi*77/16),cos(pi*91/16), cos(pi*105/16)];
% 

 
 




end

