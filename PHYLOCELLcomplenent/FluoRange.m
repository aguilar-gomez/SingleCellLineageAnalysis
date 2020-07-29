%{
This function returns the fluorescence value of a cell "i" in position "pos" from time "ini" to time "last"
%}

function [fluo]=FluoRange(ini,last,pos,i)
global segmentation
at_openSeg(pos)
clear fluo*;  
k=1;
for j=1:1:length(segmentation.tcells1(i).Obj)
    if segmentation.tcells1(i).Obj(j).image>ini-1 && segmentation.tcells1(i).Obj(j).image<last+1
        fluo(k)=segmentation.tcells1(i).Obj(j).fluoMean(1,2);
        k=k+1;
    end
    
end 