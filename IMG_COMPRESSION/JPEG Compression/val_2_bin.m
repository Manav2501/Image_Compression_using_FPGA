function [st_signed] = val_2_bin(val,nfl,fl)
    %%nfl = non-fraction-length
    %%fl = fraction-length
    
    qs=quantizer('fixed', [(nfl+fl) fl]); 
    [as,bs]=range(qs);
    st_signed = num2bin(qs,val);
 return