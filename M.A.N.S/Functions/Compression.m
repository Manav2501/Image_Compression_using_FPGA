close all
clear all

x=imread('test2.bmp');

figure,imshow(x);

f=dct2(x);
figure, imshow(f*0.01);

ff=idct2(f);
figure,imshow(ff/255);

[r,c]=size(x);
DF=zeros(r,c);
DFF=DF;
IDF=DF;
IDFF=DF;
depth=150;
N=8;

for i=1:N:r
    for j=1:N:c
        f=x(i:i+N-1,j:j+N-1);
        df=dct2(f);
        DF(i:i+N-1,j:j+N-1)=df;
        dff=idct2(df);
        DFF(i:i+N-1,j:j+N-1)=dff;
        df(N:-1:depth+1,:)=0;
        df(:,N:-1:depth+1)=0;
        IDF(i:i+N-1,j:j+N-1)=df;
        dff=idct2(df);
        IDFF(i:i+N-1,j:j+N-1)=dff;
    end
end
 figure,imshow(DF/255);
 
 
 A=DFF/255;
 figure,imshow(A);
 imwrite(A,'n.bmp');
 B=IDFF/255;
 imwrite(B,'n2.bmp');
 figure,imshow(B);