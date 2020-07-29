%{
This function can be used to extract the fluorescence values of an experiment without losing the lineage information.
The table can be written into a csv ot tsv file to exported and read in other languages 
This function generates a table with the following columns:
1. position in the microscope 
2. mother cell
3. daughter cell 
columns 4 to n are the fluorescence from t1 to tn 

Note 1: this script can be modified to normalize all the cells by substracting the variable "noise". 
This variable is generating by averaging all mother cells in t0

Note 2: in the output table mothers have themselves listed as their mothers. 
This can be useful in downstream analysis is you want to extract the mothers (mother==daughter).

%}


function table=MotherDaughterFluo(posi)
at_openSeg(posi)
global segmentation
k=1;
sum=0;
l=1;

%Modify this timepoints according to your necessities
t0=80;
t1=140;
t2=220;
t3=250;
t4=300;

%Clear variables
clear mothers*;
clear table;

for i=1:1:length(segmentation.tcells1)
    for j=1:1:length(segmentation.tcells1(i).Obj)
        if  segmentation.tcells1(i).Obj(j).image==t0 && segmentation.tcells1(i).lastFrame >tn-1
           mothers(k)=i;
           sum=sum+segmentation.tcells1(i).Obj(j).fluoMean(1,2);
           k=k+1;
        end
    end
end
j=1;
noise=sum/length(mothers); %this noise can be substracted from the fluorescence to normalize it across positions
for i=mothers
    hijas=(segmentation.tcells1(i).budTimes>t1 & segmentation.tcells1(i).budTimes<t2);
    daughters=nnz(hijas); % return non zero elements 
    alive=segmentation.tcells1(i).daughterList(hijas);
    momFluo=FluoRange(t3,tn,posi,i);
    table(j,:)=horzcat(posi,i,i,momFluo);
    j=j+1;
    for x=alive
        if segmentation.tcells1(x).N==0
            daughters=daughters-1;
            alive=alive(alive~=x);
        elseif segmentation.tcells1(x).lastFrame >tn-1
            daughterFluo=FluoRange(t3,tn,posi,x);
            table(j,:)=horzcat(posi,i,x,daughterFluo);
            j=j+1;
        end
    end
