%% LOSSY IMAGE COMPRESSION USNIG DISCRETE COSINE TRANSFORM.
function Image=DCT(filename,n,m)
% "filename" - Image_Name.extension
% "m" MSB of DCT coefficients
% "n" Number of bits per pixel 

% Matrix Intializations.
N=8;                        % (N*M) Block size for which DCT is Computed.
M=8;
Image=imread(filename);         % Reading the input image file and storing intensity values in 2-D matrix I.
Image_dim=size(Image);              % Finding the dimensions of the image file.
Image_Trsfrm.block=zeros(N,M);  % Initialising the DCT Coefficients Structure Matrix "I_Trsfrm" with the required dimensions.

Norm_Mat=[16 11 10 16 24 40 51 61       % Standard matrix used in JPEG DCT Normalization
          12 12 14 19 26 58 60 55
          14 13 16 24 40 57 69 56
          14 17 22 29 51 87 80 62
          18 22 37 56 68 109 103 77
          24 35 55 64 81 104 113 92
          49 64 78 87 103 121 120 101
          72 92 95 98 112 100 103 99];
 
save('LenaInitial.txt','Image');

%% PART-1: COMPRESSION TECHNIQUE.

% Computing the Quantized & Normalized Discrete Cosine Transform.
% Y(k,l)=(2/root(NM))*c(k)*c(l)*sigma(i=0:N-1)sigma(j=0:M-1)y(i,j)cos(pi(2i+1)k/(2N))cos(pi(2j+1)l/(2M))
% where c(u)=1/root(2) if u=0
%            = 1       if u>0

for a=1:Image_dim(1)/N
    for b=1:Image_dim(2)/M
        
        for k=1:N
            
            for l=1:M
                prod=0;
                
                for i=1:N
                    for j=1:M
                        prod=prod+double(Image(N*(a-1)+i,M*(b-1)+j))*cos(pi*(k-1)*(2*i-1)/(2*N))*cos(pi*(l-1)*(2*j-1)/(2*M));
                    end
                end
                
                if k==1
                    prod=prod*sqrt(1/N);
                else
                    prod=prod*sqrt(2/N);
                end
                
                if l==1
                    prod=prod*sqrt(1/M);
                else
                    prod=prod*sqrt(2/M);
                end
                
                Image_Trsfrm(a,b).block(k,l)=prod;
            
            end
        end
        
        %Quantizing and Dividing the resultant values by Standard JPEG matrix
        Image_Trsfrm(a,b).block=round(Image_Trsfrm(a,b).block./Norm_Mat);
    end
end

% zig-zag coding of the each 8 X 8 Block.
%It basically converts the 8*8 matrix into 1*64 vector array
for a=1:Image_dim(1)/N
    for b=1:Image_dim(2)/M
        Image_zigzag(a,b).block=zeros(1,0);
        freq_sum=2:(N+M);
        counter=1;
        for i=1:length(freq_sum)
            if i<=((length(freq_sum)+1)/2)
                if rem(i,2)~=0
                    x_indices=counter:freq_sum(i)-counter;
                else
                    x_indices=freq_sum(i)-counter:-1:counter;
                end
                    index_len=length(x_indices);
                    y_indices=x_indices(index_len:-1:1); % Creating reverse of the array as "y_indices".
                    for p=1:index_len
                        if Image_Trsfrm(a,b).block(x_indices(p),y_indices(p))<0
                            bin_eq=dec2bin(bitxor(2^n-1,abs(Image_Trsfrm(a,b).block(x_indices(p),y_indices(p)))),n);
                        else
                            bin_eq=dec2bin(Image_Trsfrm(a,b).block(x_indices(p),y_indices(p)),n);
                        end
                        Image_zigzag(a,b).block=[Image_zigzag(a,b).block,bin_eq(1:m)];
                    end
            else
                counter=counter+1;
                if rem(i,2)~=0
                    x_indices=counter:freq_sum(i)-counter;
                else
                    x_indices=freq_sum(i)-counter:-1:counter;
                end
                    index_len=length(x_indices);
                    y_indices=x_indices(index_len:-1:1); % Creating reverse of the array as "y_indices".
                    for p=1:index_len
                        if Image_Trsfrm(a,b).block(x_indices(p),y_indices(p))<0
                            bin_eq=dec2bin(bitxor(2^n-1,abs(Image_Trsfrm(a,b).block(x_indices(p),y_indices(p)))),n);
                        else
                            bin_eq=dec2bin(Image_Trsfrm(a,b).block(x_indices(p),y_indices(p)),n);
                        end
                        Image_zigzag(a,b).block=[Image_zigzag(a,b).block,bin_eq(1:m)];
                    end
            end
        end
    end
end

% Clearing unused variables from Memory space
clear Image_Trsfrm prod; 
clear x_indices y_indices counter;

% Run-Length Encoding the resulting code.
for a=1:Image_dim(1)/N
    for b=1:Image_dim(2)/M
        
        % Computing the Count values for the corresponding symbols and
        % storing them in "I_run" struct
        count=0;
        run=zeros(1,0);
        sym=Image_zigzag(a,b).block(1);
        j=1;
        block_len=length(Image_zigzag(a,b).block);
        for i=1:block_len
            if Image_zigzag(a,b).block(i)==sym
                count=count+1;
            else
                run.count(j)=count;
                run.sym(j)=sym;
                j=j+1;
                sym=Image_zigzag(a,b).block(i);
                count=1;
            end
            if i==block_len
                run.count(j)=count;
                run.sym(j)=sym;
            end
        end 
        
        % Computing the codelength needed for the count values.
        dimension=length(run.count);  % calculates number of symbols being encoded.
        maxvalue=max(run.count);  % finds the maximum count value in the count array of run structure.
        codelength=log2(maxvalue)+1;
        codelength=floor(codelength);
        
        % Encoding the count values along with their symbols.
        Image_runcode(a,b).code=zeros(1,0);
        for i=1:dimension
            Image_runcode(a,b).code=[Image_runcode(a,b).code,dec2bin(run.count(i),codelength),run.sym(i)];
        end
    end
end
% Saving the Compressed Code to Disk.
save ('LenaCompressed.txt','Image_runcode');

% Clearing unused variables from Memory Space.
clear I_zigzag run;

f=imshow(Image);
a=size(f);

