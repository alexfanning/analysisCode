
%files to be written to
excelDoc = [filename(1:end-4) '_analysis.xlsx'];

t = table(headDarkBlockAvgMat,eyeVelDarkBlockAvgMat);
t.Properties.VariableNames = {'Head' 'Eye'};
writetable(t,excelDoc,'Sheet','Vdark');
t2 = table(headVisualBlockAvgMat,drumVelVisualBlockAvgMat,eyeVelVisualBlockAvgMat,rsBlockAvgMat);
t2.Properties.VariableNames = {'Head' 'Drum' 'Eye' 'rSlip'};
writetable(t2,excelDoc,'Sheet','Visual');

for i = 1:numBlocksDark
    headDarkBlockSineMat(1:fr,i) = headDarkBlockSine{i}';
    eyeDarkBlockSineMat(1:fr,i) = eyeDarkBlockSine{i}';
end
t3 = table(headDarkBlockSineMat,eyeDarkBlockSineMat);
t3.Properties.VariableNames = {'Head' 'Eye'};
writetable(t3,excelDoc,'Sheet','Sines-fitted Vdark');
for i = 1:numBlocksVisual
    headVisualBlockSineMat(1:fr,i) = headVisualBlockSine{i}';
    eyeVisualBlockSineMat(1:fr,i) = eyeVisualBlockSine{i}';
    drumVisualBlockSineMat(1:fr,i) = drumVisualBlockSine{i}';
    rsBlockSineMat(1:fr,i) = rsBlockSine{i}';
end
t4 = table(headVisualBlockSineMat,drumVisualBlockSineMat,eyeVisualBlockSineMat,rsBlockSineMat);
t4.Properties.VariableNames = {'Head' 'Drum' 'Eye' 'rSlip'};
writetable(t4,excelDoc,'Sheet','Sines-fitted Visual');