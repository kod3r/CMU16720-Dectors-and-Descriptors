% DoGdetector
% Inputs:
% im - a gray scale image scaled between 0 and 1
% sigma0 - Gaussian filter kernel width
% k - parameter for difference of Gaussian in each layer
% levels - a vector specify the number of layers
% th_contrast - threshold for contrast
% th_r - threshold for the princiap curvature
function [locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r)

GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r);

end