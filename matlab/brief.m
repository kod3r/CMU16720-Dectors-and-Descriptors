% Get keypoints locations and compute valid BRIEF descriptors
% Inputs:
% im - a grayscale image with values from 0 to 1
function [locs, desc] = brief(im)
sigma0 = 1;
k = sqrt(2);
levels = [-1 0 1 2 3 4];
th_contrast = 0.03;
th_r = 12;

patchWidth = 9;
nbits = 256;

%[compareX, compareY] = makeTestPattern(patchWidth, nbits);
load('testPattern');

[oldlocs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r);

[locs, desc] =computeBrief(im, oldlocs, levels, compareX, compareY);
end