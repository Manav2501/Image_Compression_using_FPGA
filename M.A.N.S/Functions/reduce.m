function s =reduce(p)
        %does the source reduction
        s=cell(length(p),1);
        for i=1:length(p)
            s{i}=i;
        end
        
        while numel(s)>2
            [p,i]=sort(p); %sort the prob
            p(2)=p(1)+p(2); %add two lowest prob
            p(1)=[];   %cut away the lowest one
            s=s(i); %reorder
            s{2}={s{1},s{2}}; %merge and cut away the nodes to match prob
            s(1)=[];
        end
end
