%{
This code generates a 3d scatter plot comparing a cell in two different intervals of time
For Bheda et al. 2019, this code was used to compare the two inductions during 1 hour (20 timepoints/frames taken every 3 minutes),
1 h 15 min into the induction (45 frames)
This code will plot all the cells that are present before t0 (the first induction beginning)
%}

global segmentation
k=1;
t0= 80 %time defined to grab all cells of interest
t1= 125 %start time of first interval
t2= 146 %end time of first interval
t3= 265 %start time of second interval
t4= 286 %end time of second interval

sum=0;
clear mothers*; %reset all variables

for i=1:1:length(segmentation.tcells1)
    for j=1:1:length(segmentation.tcells1(i).Obj)
        if  segmentation.tcells1(i).Obj(j).image==t0 
           mothers(k)=i;
           sum=sum+segmentation.tcells1(i).Obj(j).fluoMean(1,2);
           k=k+1;
        end
    end
end
mothers;
k=1;
noise=sum/length(mothers)
for i=mothers
   pos1st=1;
   pos2nd=1;
   for j=1:1:length(segmentation.tcells1(i).Obj)
       
       if segmentation.tcells1(i).Obj(j).image>t1 && segmentation.tcells1(i).Obj(j).image<t2
           mothersFluo1st(k,pos1st)=segmentation.tcells1(i).Obj(j).fluoMean(1,2)-noise;
           pos1st=pos1st+1;
       elseif segmentation.tcells1(i).Obj(j).image>t3 && segmentation.tcells1(i).Obj(j).image<t4
           mothersFluo2nd(k,pos2nd)=segmentation.tcells1(i).Obj(j).fluoMean(1,2)-noise;
           pos2nd=pos2nd+1;
           
       end 
   end
   k=k+1;
end
figure
hold on;
for i=1:length(mothers)
    c = linspace(1,10,20);
    scatter3(mothersFluo1st(i,:),mothersFluo2nd(i,:),c,'filled')
end 