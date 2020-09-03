function CODE = huffman(p)
%HUFFMAN builds a variable length huffman code

%check input arguments
error(nargchk(1,1,nargin));

if (~ismatrix(p))||(min(size(p))>1)||~isreal(p)||~isnumeric(p)
    error('P must be a numeric vector');
end

global CODE %#ok<REDEF>

CODE=cell(length(p),1); %initializing the array

if length(p)>1  %when more than one symbol
    p=p/sum(p); %normalize the input prob
    s=reduce(p); %do huffman
    makecode(s,[]); %generate code reccursively
else
    CODE={'1'};
end
    





