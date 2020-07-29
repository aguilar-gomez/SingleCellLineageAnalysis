%{
Example on how to run the growth_rate function in different positions
growth_rate takes three arguments:
1. strain (ie. WT, mutant1, etc)
2. exp - experiment number, to keep track in case of having several experiments
3. pos - position in the microscope that is being analyzed
%}
fid = fopen('examplefile'.csv,'a+');
positions=[1,2,4,5,6,8,9,10,12,13,14,15,16];
exp = 5;
strain = "WT";


for pos = positions
    table=growth_rate(strain,exp,pos)
    for k=1:size(table,1)
         fprintf(fid,'%s,%s,%s,%s,%s,%s\n',table{k,:});
    end
end 



