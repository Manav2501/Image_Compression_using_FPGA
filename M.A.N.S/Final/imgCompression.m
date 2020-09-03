function Anew=imgCompression(x)

%reading the image
A=imread(x);

%get the number of pixels
[rows,columns] = size(A);
disp('No of pixels')
Number_Pixels = rows*columns;

AS=A; %copy of A

%get the row and col size
rowSize=size(AS,1);
colSize=size(AS,2);

%subtract the bytes from the image
s=int16(AS)-128; %level shifting
B=[];
B_quantized=[];
count=1;


blockSize=input('Enter 8 ---> 8X8 ||||| 16 ---> 16X16 : ')
jump=0;
zigzagcount=0;
if blockSize==8
    jump=7;
    zigzagcount=64;
    printLimit=8;
else
    jump=15;
    zigzagcount=256;
    printLimit=16;
end

%Encoding

for i=1:blockSize:rowSize
     for j=1:blockSize:colSize 
        %performing the DCT
        B(i:i+jump,j:j+jump) = dct2(s(i:i+jump,j:j+jump));
        %performing the quantization
        B_quantized(i:i+jump,j:j+jump)=Quantization(B(i:i+jump,j:j+jump),blockSize);
        z(count,1:zigzagcount)=zigzag(B_quantized(i:i+jump,j:j+jump));
        count=count+1;
     end
end
disp('Original Image')
AS(1:printLimit,1:printLimit)
disp('After Shifting')
s(1:printLimit,1:printLimit)
disp('After Applying DCT')
B(1:printLimit,1:printLimit) 
disp('After Quantization')
B_quantized(1:printLimit,1:printLimit)
z(1,1:zigzagcount);

%-------------------------------------------------------------------------------------------------------------


%Decoding

Bnew=[]; 
ASnew=[];


for i=1:blockSize:rowSize
     for j=1:blockSize:colSize 
        %Inverse of quantization
        Bnew(i:i+jump,j:j+jump)=inverseQuantization(B_quantized(i:i+jump,j:j+jump),blockSize);
        %performing the inverse DCT
        ASnew(i:i+jump,j:j+jump) = round(idct2(Bnew(i:i+jump,j:j+jump)));
     end
end

Anew=ASnew+128; %shifting

Anew=uint8(Anew);


subplot(1,2,1)
imshow(A)
title('Original Image')
subplot(1,2,2)
imshow(Anew)
title('Compressed Image')
disp('Error')
Error=abs(sum(sum(imsubtract(A,Anew).^2)))/Number_Pixels %MSE

end



        
