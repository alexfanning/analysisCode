function [saccades, artifacts] = removeArtifacts(saccades, magnetPos,len,neighborThres)
    % TODO: Get rid of magic numbers
    remove = zeros(size(saccades, 1), 1);
    for i = 1:size(saccades, 1)
        % If it returns to starting pos within len ms, then it's removed
        start = saccades(i, 1);
        stop = saccades(i, 2);
        if stop + len < numel(magnetPos)
            postSaccade = magnetPos(stop:stop + len);
        else
            postSaccade = magnetPos(stop:end);
        end
        if magnetPos(start) > min(postSaccade) && magnetPos(start) < max(postSaccade)
            remove(i) = 1;
        end

        % Consider the neighboring saccade before me
        % If I move back to near its starting position, then remove both of us
        % "Near" is within 1/2 of the amplitude of the neighbor
        if i >= 2
            displacement = abs(magnetPos(saccades(i - 1, 1)) - magnetPos(saccades(i, 2)));
            timeDiff = saccades(i, 1) - saccades(i - 1, 2); % Time from prev neighbor's end to my start
            
            prevAmp = range(magnetPos(saccades(i - 1, 1):saccades(i - 1, 2)));
            currAmp = range(magnetPos(saccades(i, 1):saccades(i, 2)));
            
            prevSign = sign(magnetPos(saccades(i - 1, 2)) - magnetPos(saccades(i - 1, 1)));
            currSign = sign(magnetPos(saccades(i, 2)) - magnetPos(saccades(i, 1)));
            
            if prevSign ~= currSign && timeDiff < neighborThres
                if displacement < 0.5 * prevAmp
                    remove(i) = 1;
                    remove(i - 1) = 1;
                elseif(currAmp < prevAmp)
                    remove(i) = 1;
                else
                    remove(i - 1) = 1;
                end
            end
        end
    end
    remove = logical(remove);
    
    artifacts = saccades(remove, :); % Returns the things that are removed
    saccades(remove, :) = [];
end