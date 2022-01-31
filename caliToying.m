
cr1 = vertcat([frameData.cr1_x; frameData.cr1_y])';
scatter(cr1(:,1),cr1(:,2))
plot(cr1)

crRadii = [frameData.cr1_r; frameData.cr2_r]';
plot(crRadii)

pupilRadius = [frameData.pupil_r1; frameData.pupil_r2]';
pupilRadius1 = pupilRadius(:,1)';
pupilRadius2 = diff(pupilRadius1,2);

figure()
subplot(3,1,1); hold on
plot(pupilRadius(:,1))
subplot(3,1,2); hold on
plot(pupilRadius(:,2))
subplot(3,1,3); hold on
plot(pupilRadius2)

pupilRadiusFilt = zeros(1,length(pupilRadius2));
for k = 1:length(pupilRadius2)
    if pupilRadius2(k) > 5
        pupilRadiusFilt(k) = 1;
    else
        pupilRadiusFilt(k) = 0;
    end
end
mask = ones(1,7);
pupilRadiusFiltNew = conv(pupilRadiusFilt,mask);
pupilRadiusFiltNew = ~pupilRadiusFiltNew;

pupilRadiusNew = pupilRadius1;
pupilRadiusNew(~pupilRadiusFiltNew) = NaN;


figure(); hold on
plot(pupilRadius1)
plot(pupilRadiusNew)
