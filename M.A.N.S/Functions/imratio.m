function cr = imratio(f1,f2)
%IMRATIO computes the ratio of the bytes in two images
%F1 and F2 are the original and compressed image and CR is the compression
%ratio

error(nargchk(2,2,nargin)); %check input arguements
cr=bytes(f1)/bytes(f2); %compute the ratio



end


