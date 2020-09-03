f1=@(block) dct2(block.data);
f2=@(block) idct2(block.data);

Image=imread('test2.bmp');
f=dct2(Image);
figure,imshow(f*0.01);
If=idct(f);
figure,imshow(If/255);
imwrite(Image,'newtest2.bmp');
figure,imshow(Image);
J=blockproc(Image,[8,8],f1);
depth=find(abs(J)<1);
J(depth)=zeros(size(depth));
k=blockproc(J,[8,8],f2)/255;
figure,imshow(k);
imwrite(k,'newnewtest2.bmp');

cr=numel(J)/numel(depth);