function scatterCorr(varargin)
%%Plot fluorescence as a function of the stimulus
if varargin{end} == 0
    if varargin{14} == 0
        b = 1;
        if varargin{9} == 0
            t = 1;
        else
            t = 2;
        end
    else
        b = 2;
        if varargin{9} == 0
            t = 2;
        else
            t = 1;
        end
    end
    
    if varargin{14} == 0 || varargin{14} == 1 && varargin{9} ~= 2
        figure()
        subplot(2,2,1); hold on
        for i = 1:length(varargin{1})
            if ~isnan(varargin{1}(i)) && ~isnan(varargin{5}(t,i))
                    scatter(abs(varargin{5}(t,i)),varargin{1}(i)*100,'Filled',varargin{11});
            end
        end

        for i = 1:length(varargin{2})
            if ~isnan(varargin{2}(i)) && ~isnan(varargin{7}(b,i))
                scatter(abs(varargin{7}(b,i)),varargin{2}(i)*100,'filled','k');
            end
        end

        fit = plot(varargin{10}{1});
        fit(1).Marker = 'none';
        fit(2).Color = 'k';
        fit(3).Color = 'k';
        fit(4).Color = 'k';
        h = plot(varargin{10}{2});
        h(1).Marker = 'none';
        h(2).Color = 'k';
        h(3).Color = 'k';
        h(4).Color = 'k';
        legend off
        sgtitle(varargin{12});
        title('')
        xlabel('')
        ylabel('% DeltaF/G');

        %% Plot fluorescence amplitude as a function of timing re stimulus
        subplot(2,2,2); hold on
        for i = 1:length(varargin{1})
            if ~isnan(varargin{1}(i)) && ~isnan(varargin{6}(t,i))
                scatter(varargin{6}(t,i),varargin{1}(i)*100,'Filled',varargin{11});
            end
        end

        for i = 1:length(varargin{2})
            if ~isnan(varargin{2}(i)) && ~isnan(varargin{8}(b,i))
                scatter(varargin{8}(b,i),varargin{2}(i)*100,'filled','k');
            end
        end

        fit = plot(varargin{10}{3});
        fit(1).Marker = 'none';
        fit(2).Color = 'k';
        fit(3).Color = 'k';
        fit(4).Color = 'k';
        h = plot(varargin{10}{4});
        h(1).Marker = 'none';
        h(2).Color = 'k';
        h(3).Color = 'k';
        h(4).Color = 'k';
        title('')
        xlabel('')
        ylabel('');
        legend off

        %% Plot fluorescence AUC as a function of stimulus velocity
        subplot(2,2,3); hold on
        for i = 1:length(varargin{3})
            if ~isnan(varargin{3}(i)) && ~isnan(varargin{5}(t,i))
                scatter(abs(varargin{5}(t,i)),varargin{3}(i),'Filled',varargin{11});
            end
        end

        for i = 1:length(varargin{4})
            if ~isnan(varargin{4}(i)) && ~isnan(varargin{7}(b,i))
                scatter(abs(varargin{7}(b,i)),varargin{4}(i),'filled','k');
            end
        end

        fit = plot(varargin{10}{5});
        fit(1).Marker = 'none';
        fit(2).Color = 'k';
        fit(3).Color = 'k';
        fit(4).Color = 'k';
        h = plot(varargin{10}{6});
        h(1).Marker = 'none';
        h(2).Color = 'k';
        h(3).Color = 'k';
        h(4).Color = 'k';
        legend off
        title('')
        xlabel(varargin{13}{1})
        ylabel('AUC');

        %% Plot fluorescence AUC as a function of timing re stimulus
        subplot(2,2,4); hold on
        for i = 1:length(varargin{3})
            if ~isnan(varargin{3}(i)) && ~isnan(varargin{6}(t,i))
                scatter(varargin{6}(t,i),varargin{3}(i),'Filled',varargin{11});
            end
        end

        for i = 1:length(varargin{4})
            if ~isnan(varargin{4}(i)) && ~isnan(varargin{8}(b,i))
                scatter(varargin{8}(b,i),varargin{4}(i),'filled','k');
            end
        end

        fit = plot(varargin{10}{7});
        fit(1).Marker = 'none';
        fit(2).Color = 'k';
        fit(3).Color = 'k';
        fit(4).Color = 'k';
        h = plot(varargin{10}{8});
        h(1).Marker = 'none';
        h(2).Color = 'k';
        h(3).Color = 'k';
        h(4).Color = 'k';
        title('')
        xlabel(varargin{13}{2})
        ylabel('');
        legend off
    end
elseif varargin{end} == 1
    
    figure()
    subplot(2,2,1); hold on
    for i = 1:length(varargin{1})
        if ~isnan(varargin{1}(i)) && ~isnan(varargin{3}(2,i))
            scatter(abs(varargin{3}(2,i)),varargin{1}(i)*100,'Filled',varargin{7});
        end
    end

    h = plot(varargin{6}{1});
    h(1).Marker = 'none';
    h(2).Color = 'k';
    h(3).Color = 'k';
    h(4).Color = 'k';
    legend off
    sgtitle(varargin{8});
    title('')
    xlabel('')
    ylabel('% DeltaF/G');

    %% Plot fluorescence amplitude as a function of timing re retinal slip
    subplot(2,2,2); hold on
    for i = 1:length(varargin{1})
        if ~isnan(varargin{1}(i)) && ~isnan(varargin{4}(2,i))
            scatter(varargin{4}(2,i),varargin{1}(i)*100,'Filled',varargin{7});
        end
    end

    h = plot(varargin{6}{2});
    h(1).Marker = 'none';
    h(2).Color = 'k';
    h(3).Color = 'k';
    h(4).Color = 'k';
    title('')
    xlabel('')
    ylabel('');
    legend off

    %% Plot fluorescence AUC as a function of retinal slip velocity
    subplot(2,2,3); hold on
    for i = 1:length(varargin{2})
        if ~isnan(varargin{2}(i)) && ~isnan(varargin{3}(2,i))
            scatter(abs(varargin{3}(2,i)),varargin{2}(i),'Filled',varargin{7});
        end
    end

    h = plot(varargin{6}{3});
    h(1).Marker = 'none';
    h(2).Color = 'k';
    h(3).Color = 'k';
    h(4).Color = 'k';
    legend off
    title('')
    ylabel('AUC');
    xlabel(varargin{9}{1});

    %% Plot fluorescence amplitude as a function of timing re retinal slip
    subplot(2,2,4); hold on
    for i = 1:length(varargin{2})
        if ~isnan(varargin{2}(i)) && ~isnan(varargin{4}(2,i))
            scatter(varargin{4}(2,i),varargin{2}(i),'Filled',varargin{7});
        end
    end

    h = plot(varargin{6}{4});
    h(1).Marker = 'none';
    h(2).Color = 'k';
    h(3).Color = 'k';
    h(4).Color = 'k';
    title('')
    xlabel(varargin{9}{2});
    ylabel('');
    legend off
    
elseif varargin{end} == 2
    time = 1:length(varargin{1});
    time(2,:) = 1:length(varargin{2});
    figure()
    subplot(2,2,1); hold on
    for i = 1:length(varargin{1})
        scatter(time(2,:),varargin{2}(2,i),'Filled');
        scatter(time(1,:),varargin{1}(2,i),'Filled');
    end

    h = plot(varargin{4}{1});
    h(1).Marker = 'none';
    h(2).Color = 'k';
    h(3).Color = 'k';
    h(4).Color = 'k';
    legend off
    sgtitle(varargin{6});
    title('')
    xlabel('')
    ylabel('% DeltaF/G');
elseif varargin{end} == 3
    if varargin{14} == 0
        b = 1;
        if varargin{9} == 0
            t = 1;
        else
            t = 2;
        end
    else
        b = 2;
        if varargin{9} == 0
            t = 2;
        else
            t = 1;
        end
    end
    %% Plot eye velocity as a function of prior trial's calcium amplitude
    figure()
    subplot(2,2,1); hold on
    for i = 1:length(varargin{1})
        if ~isnan(varargin{1}(i)) && ~isnan(varargin{5}(t,i))
            scatter(abs(varargin{5}(t,i)),varargin{1}(i)*100,'Filled',varargin{11});
        end
    end
    
    for i = 1:length(varargin{2})
        if ~isnan(varargin{2}(i)) && ~isnan(varargin{7}(b,i))
            scatter(abs(varargin{7}(b,i)),varargin{2}(i)*100,'filled','k');
        end
    end
    
    fit = plot(varargin{10}{1});
    fit(1).Marker = 'none';
    fit(2).Color = 'k';
    fit(3).Color = 'k';
    fit(4).Color = 'k';
    h = plot(varargin{10}{2});
    h(1).Marker = 'none';
    h(2).Color = 'k';
    h(3).Color = 'k';
    h(4).Color = 'k';
    legend off
    sgtitle(varargin{12});
    title('')
    xlabel('')
    ylabel('% DeltaF/G');
    
    %% Plot eye velocity as a function of prior trial's calcium time re retinal slip
    subplot(2,2,2); hold on
    for i = 1:length(varargin{1})
        if ~isnan(varargin{5}(t,i)) && ~isnan(varargin{6}(t,i))
            scatter(varargin{6}(t,i),abs(varargin{5}(t,i)),'Filled',varargin{11});
        end
    end
    
    for i = 1:length(varargin{2})
        if ~isnan(varargin{7}(b,i)) && ~isnan(varargin{8}(b,i))
            scatter(varargin{8}(b,i),abs(varargin{7}(b,i)),'filled','k');
        end
    end
    
    fit = plot(varargin{10}{3});
    fit(1).Marker = 'none';
    fit(2).Color = 'k';
    fit(3).Color = 'k';
    fit(4).Color = 'k';
    h = plot(varargin{10}{4});
    h(1).Marker = 'none';
    h(2).Color = 'k';
    h(3).Color = 'k';
    h(4).Color = 'k';
    title('')
    xlabel(varargin{13}{2})
    ylabel('');
    legend off
    
    %% Plot fluorescence AUC as a function of stimulus velocity
    subplot(2,2,3); hold on
    for i = 1:length(varargin{3})
        if ~isnan(varargin{3}(i)) && ~isnan(varargin{5}(t,i))
            scatter(abs(varargin{5}(t,i)),varargin{3}(i),'Filled',varargin{11});
        end
    end
    
    for i = 1:length(varargin{4})
        if ~isnan(varargin{4}(i)) && ~isnan(varargin{7}(b,i))
            scatter(abs(varargin{7}(b,i)),varargin{4}(i),'filled','k');
        end
    end
    
    fit = plot(varargin{10}{5});
    fit(1).Marker = 'none';
    fit(2).Color = 'k';
    fit(3).Color = 'k';
    fit(4).Color = 'k';
    h = plot(varargin{10}{6});
    h(1).Marker = 'none';
    h(2).Color = 'k';
    h(3).Color = 'k';
    h(4).Color = 'k';
    legend off
    title('')
    xlabel(varargin{13}{1})
    ylabel('AUC');
    
elseif varargin{end} == 4
    if varargin{14} == 0
        b = 1;
        if varargin{15} == 0
            t = 2;
        else
            t = 1;
        end
    else
        b = 2;
        if varargin{15} == 0
            t = 2;
        else
            t = 1;
        end
    end
    
    if varargin{14} == 0 || varargin{14} == 1
        figure()
        subplot(2,2,1); hold on
        for i = 1:length(varargin{1})
            if ~isnan(varargin{1}(i)) && ~isnan(varargin{5}(t,i))
                    scatter(abs(varargin{5}(t,i)),varargin{1}(i)*100,'Filled',varargin{11});
            end
        end

        for i = 1:length(varargin{2})
            if ~isnan(varargin{2}(i)) && ~isnan(varargin{7}(b,i))
                scatter(abs(varargin{7}(b,i)),varargin{2}(i)*100,'filled','k');
            end
        end

        fit = plot(varargin{10}{1});
        fit(1).Marker = 'none';
        fit(2).Color = 'k';
        fit(3).Color = 'k';
        fit(4).Color = 'k';
        h = plot(varargin{10}{2});
        h(1).Marker = 'none';
        h(2).Color = 'k';
        h(3).Color = 'k';
        h(4).Color = 'k';
        legend off
        sgtitle(varargin{12});
        title('')
        xlabel('')
        ylabel('% DeltaF/G');

        %% Plot fluorescence amplitude as a function of timing re stimulus
        subplot(2,2,2); hold on
        for i = 1:length(varargin{1})
            if ~isnan(varargin{1}(i)) && ~isnan(varargin{6}(t,i))
                scatter(varargin{6}(t,i),varargin{1}(i)*100,'Filled',varargin{11});
            end
        end

        for i = 1:length(varargin{2})
            if ~isnan(varargin{2}(i)) && ~isnan(varargin{8}(b,i))
                scatter(varargin{8}(b,i),varargin{2}(i)*100,'filled','k');
            end
        end

        fit = plot(varargin{10}{3});
        fit(1).Marker = 'none';
        fit(2).Color = 'k';
        fit(3).Color = 'k';
        fit(4).Color = 'k';
        h = plot(varargin{10}{4});
        h(1).Marker = 'none';
        h(2).Color = 'k';
        h(3).Color = 'k';
        h(4).Color = 'k';
        title('')
        xlabel('')
        ylabel('');
        legend off

        %% Plot fluorescence AUC as a function of stimulus velocity
        subplot(2,2,3); hold on
        for i = 1:length(varargin{3})
            if ~isnan(varargin{3}(i)) && ~isnan(varargin{5}(t,i))
                scatter(abs(varargin{5}(t,i)),varargin{3}(i),'Filled',varargin{11});
            end
        end

        for i = 1:length(varargin{4})
            if ~isnan(varargin{4}(i)) && ~isnan(varargin{7}(b,i))
                scatter(abs(varargin{7}(b,i)),varargin{4}(i),'filled','k');
            end
        end

        fit = plot(varargin{10}{5});
        fit(1).Marker = 'none';
        fit(2).Color = 'k';
        fit(3).Color = 'k';
        fit(4).Color = 'k';
        h = plot(varargin{10}{6});
        h(1).Marker = 'none';
        h(2).Color = 'k';
        h(3).Color = 'k';
        h(4).Color = 'k';
        legend off
        title('')
        xlabel(varargin{13}{1})
        ylabel('AUC');

        %% Plot fluorescence AUC as a function of timing re stimulus
        subplot(2,2,4); hold on
        for i = 1:length(varargin{3})
            if ~isnan(varargin{3}(i)) && ~isnan(varargin{6}(t,i))
                scatter(varargin{6}(t,i),varargin{3}(i),'Filled',varargin{11});
            end
        end

        for i = 1:length(varargin{4})
            if ~isnan(varargin{4}(i)) && ~isnan(varargin{8}(b,i))
                scatter(varargin{8}(b,i),varargin{4}(i),'filled','k');
            end
        end

        fit = plot(varargin{10}{7});
        fit(1).Marker = 'none';
        fit(2).Color = 'k';
        fit(3).Color = 'k';
        fit(4).Color = 'k';
        h = plot(varargin{10}{8});
        h(1).Marker = 'none';
        h(2).Color = 'k';
        h(3).Color = 'k';
        h(4).Color = 'k';
        title('')
        xlabel(varargin{13}{2})
        ylabel('');
        legend off
    end
end

