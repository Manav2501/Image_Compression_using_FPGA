function b = bytes(f)
%return the number of bytes in input f
if ischar(f)
    info=dir(f);
    b=info.bytes;
else if isstruct(f)
        b=0;
        fields=fieldnames(f);
        for k=1:length(fields)
            elements=f.(fields{k});
            for m=1:length(elements)
                b=b+bytes(elements(m));
            end
        end
    else
        info=whos('f');
        b=info.bytes;
    end
    

end

