function [linearFit,linearFitR2] = linearFitting(variable1,variable2)

linearFit = fitlm(variable1,variable2);
linearFitR2 = linearFit.Rsquared.Ordinary;