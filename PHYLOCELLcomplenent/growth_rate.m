%{
This function calculated the growth rate of the cells in repression and induction intervals.
It creates a table where each row has a label indicating if the growth rate is during repression or induction.

growth_rate takes seven arguments:

1. strain (ie. WT, mutant1, etc)
2. exp - experiment number, to keep track in case of having several experiments
3. pos - position in the microscope that is being analyzed
arguments 4,5,6,7 correspond to timepoints:
| t0 | repression_1 | t1 | induction_1 | t2 | repression_2 | t3 | induction_2 | t4 |

The growth rate is defined as the number of frames between a cell appearing and a cell dividing.

The output of this function is a table with the following columns:
1. strain (ie. WT, mutant1, etc)
2. experiment number, to keep track in case of having several experiments
3. position in the microscope that is being analyzed
4. cell number 
5. growth rate
6. induction or repression media for growing 

%}

function table=growth_rate(strain,exp,pos,t1=80,t2=140,t3=220,t4=280)
at_openSeg(pos)
global segmentation
j=1;
for cell = segmentation.tcells1
    birthTime = cell.detectionFrame;
    DivisionTimes = cell.budTimes;
    if  birthTime > 1 && ~isempty(DivisionTimes)
        %first repression or second repression
        if (birthTime > 1 && birthTime < t1 && DivisionTimes(1) < t1) || (birthTime >= t2 && birthTime < t3 && DivisionTimes(1) < t3) 
            growth_rate = DivisionTimes(1)-birthTime;
            table(j,:)=horzcat(strain,exp,pos,cell.N,growth_rate, "repression");
            j=j+1;
        end
        %first induction or second induction
        if (birthTime >= t1 && birthTime < t2 && DivisionTimes(1) < t2) || (birthTime >= t3 && birthTime < t4 && DivisionTimes(1) < t4) 
            growth_rate = DivisionTimes(1)-birthTime;
            table(j,:)=horzcat(strain,exp,pos,cell.N,growth_rate, "induction");
            j=j+1;
        end      
    end
end

