function[randSortReshape,conditionIdxs] = randBlockSort(dataRand,numBlocksL,numFreq,numTestPerFreq)

numRow05 = 1;
numRow1 = 1;
numRow2 = 1;
numRow4 = 1;
numRow5 = 1;
numRow6 = 1;

randBlockStr = strsplit(dataRand{1}{1},',');
randBlock = NaN(numBlocksL,1);
for i = 1:numBlocksL
    randBlock(i) = str2double(randBlockStr{i});
end

randSort = cell(6,4);
for i = 1:numBlocksL
    if randBlock(i) == 0.5
        randSort{1,numRow05} = [i; randBlock(i)];
        numRow05 = numRow05 + 1;
    elseif randBlock(i) == 1
        randSort{2,numRow1} = [i; randBlock(i)];
        numRow1 = numRow1 + 1;
    elseif randBlock(i) == 2
        randSort{3,numRow2} = [i; randBlock(i)];
        numRow2 = numRow2 + 1;
    elseif randBlock(i) == 4
        randSort{4,numRow4} = [i; randBlock(i)];
        numRow4 = numRow4 + 1;
    elseif randBlock(i) == 5
        randSort{5,numRow5} = [i; randBlock(i)];
        numRow5 = numRow5 + 1;
    elseif randBlock(i) == 6
        randSort{6,numRow6} = [i; randBlock(i)];
        numRow6 = numRow6 + 1;
    end
end

randSort1 = [randSort{:}];
randSortReshape = reshape(randSort1(1,1:18),6,3);
conditionIdxs = cell(1,round(numBlocksL/numFreq))
for i = 1:6
    conditionIdxs{i} = randSortReshape(i,:);
end
conditionIdxs{5}(end+1) = randSort1(1,19);
conditionIdxs{6}(end+1) = randSort1(1,20);

