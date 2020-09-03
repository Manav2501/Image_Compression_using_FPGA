function makecode(sc,codeword)
%scanning the nodes of huffman source reduction tree recursively to
%generate the indicated variable length code

global CODE
if isa(sc,'cell')
    makecode(sc{1},[codeword 0]); %for cell array nodes add a 0 if the first element or a 1 if the 2nd element  
    makecode(sc{2},[codeword 1]);
else
    CODE{sc}=char('0'+codeword);
end
end
