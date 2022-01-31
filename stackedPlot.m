%%yourCalciumEventData variable should be organized as a matrix with each
%%column representing a different calcium event trace
s = stackedplot(yourCalciumEventData(:,1:5));
for i = 1:5
    s.AxesProperties(i).YLimits = [-0,01 0.07];
end