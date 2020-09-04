function FWHM = fwhm(temp_pulse)
%% Cálculo FWHM
% Find the half max value.
halfMax = (1/2)*(min(temp_pulse) + max(temp_pulse));
% Find where the data first drops below half the max.
index1 = find(temp_pulse>=halfMax,1,'first');
% Find where the data last rises above half the max.
index2 = find(temp_pulse>=halfMax,1,'last');
FWHM = index2 - index1 + 1; % FWHM in indexes.
end