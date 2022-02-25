
function [f0,deltaF] = getf0(f,W,f0smoothFactor,g) 


%F is the raw fluorescence signal
%W is the width of the sliding Window (~300 seems good for your data).
%But play with it to see how it changes
%%
N = length(f);
for i = 1:N  %Loop through each time sample
    
    dom = i-W/2:i+W/2;
    dom = dom(find(dom>=1 & dom<=N));
    pc = f(dom);  %Get a window of the fluorescence signal around time point i
    mi = prctile(pc,15); %10
    ma = prctile(pc,25); %20
    id = find(pc>mi & pc<ma);
    f0(i) = median(pc(id));  %To get F0 at this time point, compute the median based on a subsample of the window, median(pc(id));
      
end

f0smooth = smooth(f0,f0smoothFactor);
deltaF = ((f-f0smooth)./g);

%Now plot
figure();
subplot(2,1,1)
plot(f(1:(end-1))); hold on
plot(f0(1:(end-1)),'r')
plot(f0smooth(1:(end-1)), 'g')
legend('f','f0','f0smoothed')
ylabel('F (AUs)')

subplot(2,1,2)
plot(deltaF(1:(end-1)))
ylabel('\DeltaF/G')
xlabel('Frame #')


    
