function y = matrixToHuffman(x)
%Huffman encodes matrix x
if ~ismatrix(x)||~isreal(x)||(~isnumeric(x)&&islogical(x))
    error('X must be a 2D real numeric or logical matrix');
end

y.size =uint32(size(x)); %store the size ffo input x

x=round(double(x));%find the range of x and store its min 
xmin=min(x(:));
xmax=max(x(:));

pmin=double(int16(xmin));
pmin=uint16(pmin+32768);
y.min=pmin;

%compute the input histogram bet xmin and xmax with unit width bins
x=x(:)';
h=histc(x,xmin:xmax);
if max(h)>65535
    h=65535*h/max(h);
end
h=uint16(h);
y.hist=h;
%code the input matrix and store the result

map=huffman(double(h));
hx=map(x(:)-xmin+1);
hx=char(hx)';
hx(hx==' ')=[];
ysize=ceil(length(hx)/16);
hx16=repmat('0',1,ysize*16);
hx16(1:length(hx))=hx;
hx16=reshape(hx16,16,ysize);
hx16=hx16'-'0';
twos=pow2(15:-1:0);
y.code=uint16(sum(hx16.* twos(ones(ysize,1),:),2))';



end

