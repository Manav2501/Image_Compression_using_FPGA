function [dctmat] = DCT(block)
%Performs dct of an 8x8 block
dcttmp = [ 1/sqrt(2), 1/sqrt(2), 1/sqrt(2), 1/sqrt(2), 1/sqrt(2), 1/sqrt(2), 1/sqrt(2), 1/sqrt(2)
    cos(pi/16), cos(pi*3/16), cos(pi*5/16), cos(pi*7/16), cos(pi*9/16), cos(pi*11/16), cos(pi*13/16), cos(pi*15/16)
    cos(pi*2/16), cos(pi*6/16), cos(pi*10/16), cos(pi*14/16), cos(pi*18/16), cos(pi*22/16), cos(pi*26/16), cos(pi*30/16)
    cos(pi*3/16), cos(pi*9/16), cos(pi*15/16), cos(pi*21/16), cos(pi*27/16), cos(pi*33/16), cos(pi*39/16), cos(pi*45/16)
    cos(pi*4/16), cos(pi*12/16),cos(pi*20/16), cos(pi*28/16),cos(pi*36/16), cos(pi*44/16),cos(pi*52/16), cos(pi*60/16)
    cos(pi*5/16), cos(pi*15/16),cos(pi*25/16), cos(pi*35/16),cos(pi*45/16), cos(pi*55/16),cos(pi*65/16), cos(pi*75/16)
    cos(pi*6/16), cos(pi*18/16),cos(pi*30/16), cos(pi*42/16),cos(pi*54/16), cos(pi*66/16),cos(pi*78/16), cos(pi*90/16)
    cos(pi*7/16), cos(pi*21/16),cos(pi*35/16), cos(pi*49/16),cos(pi*63/16), cos(pi*77/16),cos(pi*91/16), cos(pi*105/16)];

dctmat=(dcttmp/2)*dcttmp*(inv(dcttmp)/2); %%does DCT

end

