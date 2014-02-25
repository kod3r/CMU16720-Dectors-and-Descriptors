%%Obtain DoG Pyramid
% inputs
% GaussianPyramid - Gaussian pyramid 
% levels - a vector specifying the levels of the pyramid
function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
DoGLevels = zeros(1,length(levels)-1);
DoGPyramid = zeros([size(GaussianPyramid(:,:,1)), length(levels)-1]);

for i = 1:length(levels)-1
    DoGPyramid(:,:,i) = GaussianPyramid(:,:,i) - GaussianPyramid(:,:,i+1);
end

end