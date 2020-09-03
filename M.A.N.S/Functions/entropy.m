function h = entropy(x,n)
%ENTROPY computes the first order estimate of the entropy of a matrix

error(nargchk(1,2,nargin));
if nargin<2
    n=256;
end
x=double(x);
xh= hist(x(:),n);
xh=xh/sum(xh(:));

%make mask to eliminate 0's since log2(0)=-inf
i=find(xh);
h=-sum(xh(i).*log2(xh(i))); %compute entropy

end

