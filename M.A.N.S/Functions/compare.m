function rmse = compare(f1,f2,scale)
%COMPARE computes and displays the error between two matrices

error(nargchk(2,3,nargin));
if nargin<3
    scale=1;
end
%compute rmse 
e=double(f1)-double(f2);
[m,n]=size(e);
rmse=sqrt(sum(e(:).^2)/(m*n));

if rmse
    %form error histogram
    emax=max(abs(e(:)));
    [h,x]=hist(e(:),emax);
    if length(h)>=1
        figure;
        bar(x,h,'k');
        %scale the error imagae symmetrically and display 
        emax=emax/scale;
        e=mat2gray(e,[-emax,emax]);
        figure;
        imshow(e);
    end
end


end

