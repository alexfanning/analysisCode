function [dataOutBlock,dataOutBlockTrunc,dataOutBlockMat] = segmenting(dataInBlock,start,startRec,endTime,nthTime,fr,frequency,numTime,keepData,visualRef)

if start(1) ~= startRec(1)
    if length(dataInBlock) - (start(nthTime) - startRec(1)) >= keepData
        dataOutBlock = dataInBlock((start(nthTime) - startRec(1)):(endTime(nthTime) - startRec(1))+300);
        dataOutBlockTrunc = dataOutBlock(1:keepData);
        dataOutBlockMat = reshape(dataOutBlockTrunc,fr*(1/frequency),numTime*frequency);
    else
        dataOutBlock = dataInBlock((start(nthTime) - startRec(1)):(endTime(nthTime) - startRec(1)));
        dataOutBlockTrunc = dataOutBlock(1:keepData);
        dataOutBlockMat = reshape(dataOutBlockTrunc,fr*(1/frequency),numTime*frequency);
    end
elseif start(1) ~= startRec(1) && visualRef == 1
    dataOutBlock = dataInBlock((start(nthTime) - startRec(1)):(endTime(nthTime) - startRec(1))+300);
    if length(dataOutBlock) >= keepData
        dataOutBlockTrunc = dataOutBlock(1:keepData);
        dataOutBlockMat = reshape(dataOutBlockTrunc,fr*(1/frequency),numTime*frequency);
    end
else
    dataOutBlock = dataInBlock((start(nthTime)+1 - startRec(1)):(endTime(nthTime) - startRec(1))+300);
    dataOutBlockTrunc = dataOutBlock(1:keepData);
    dataOutBlockMat = reshape(dataOutBlockTrunc,fr*(1/frequency),numTime*frequency);
end