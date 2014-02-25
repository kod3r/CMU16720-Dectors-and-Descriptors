% Detect local extrema in both scale and space
% Inputs:
% DoGPyramid - difference of Gaussian pyramid
% DoG_levels - a vector specify the level of DoG
% PrincipalCurvature - matrix for each point contains the curvature ratio R
% th_contrast - threshold for the contrast
% th_r - threshold for curvature ratio
function [locs] = getLocalExtrema(DoGPyramid, DoG_levels, PrincipalCurvature, th_contrast, th_r)
[m, n] = size(DoGPyramid(:,:,1));
xindex = zeros(0, 1);
yindex = zeros(0, 1);
point_level = zeros(0, 1);

%for first layer
curLevel = DoGPyramid(:, :, 1);
curDoG = PrincipalCurvature(:, :, 1);
for i = 2:m-1
    for j = 2:n-1
        neighbors = [curLevel(i-1, j-1) curLevel(i-1, j) curLevel(i-1, j+1) ...
                curLevel(i, j-1) curLevel(i, j) curLevel(i, j+1) ...
                curLevel(i+1, j-1) curLevel(i+1, j) curLevel(i+1, j+1)];
            if (curLevel(i,j) == min(neighbors) || curLevel(i,j) == max(neighbors))
                if curLevel(i, j) > th_contrast && curDoG(i, j) < th_r
                    xindex = [xindex; i];
                    yindex = [yindex; j];
                    point_level = [point_level; 1];
                end
            end
    end
end

% for medium layers
for level = 2:length(DoG_levels)-1
    curLevel = DoGPyramid(:, :, level);
    curDoG = PrincipalCurvature(:, :, level);
    
    % Get the local extrema for each layer
    for i = 2:m-1
        for j = 2:n-1
            neighbors = [curLevel(i-1, j-1) curLevel(i-1, j) curLevel(i-1, j+1) ...
                curLevel(i, j-1) curLevel(i, j) curLevel(i, j+1) ...
                curLevel(i+1, j-1) curLevel(i+1, j) curLevel(i+1, j+1)];
            if (curLevel(i,j) == min(neighbors) || curLevel(i,j) == max(neighbors))
                
                % check the extrema for down layer
                upLevel = DoGPyramid(:,:, level+1);
                neighbors = [curLevel(i, j) upLevel(i-1, j-1) upLevel(i-1, j) upLevel(i-1, j+1) ...
                    upLevel(i, j-1) upLevel(i, j) upLevel(i, j+1) ...
                    upLevel(i+1, j-1) upLevel(i+1, j) upLevel(i+1, j+1)];
                if (curLevel(i,j) == min(neighbors) || curLevel(i,j) == max(neighbors))
                    
                    %check the extrema for down layer
                    downLevel = DoGPyramid(:, :, level-1);
                    neighbors = [curLevel(i, j) downLevel(i-1, j-1) downLevel(i-1, j) downLevel(i-1, j+1) ...
                        downLevel(i, j-1) downLevel(i, j) downLevel(i, j+1) ... 
                        downLevel(i+1, j-1) downLevel(i+1, j) downLevel(i+1, j+1)];
                    if (curLevel(i,j) == min(neighbors) || curLevel(i,j) == max(neighbors))
                        
                        %check for contrast and threshold

                        if curLevel(i, j) > th_contrast && curDoG(i, j) < th_r
                            xindex = [xindex; i];
                            yindex = [yindex; j];
                            point_level = [point_level; level];
                        end
                    end
                end
            end
        end
    end
end

% for the last layer
lastlayer = length(DoG_levels);
curLevel = DoGPyramid(:, :, lastlayer);
curDoG = PrincipalCurvature(:, :, lastlayer);
for i = 2:m-1
    for j = 2:n-1
        neighbors = [curLevel(i-1, j-1) curLevel(i-1, j) curLevel(i-1, j+1) ...
                curLevel(i, j-1) curLevel(i, j) curLevel(i, j+1) ...
                curLevel(i+1, j-1) curLevel(i+1, j) curLevel(i+1, j+1)];
            if (curLevel(i,j) == min(neighbors) || curLevel(i,j) == max(neighbors))
                if curLevel(i, j) > th_contrast && curDoG(i, j) < th_r
                    xindex = [xindex; i];
                    yindex = [yindex; j];
                    point_level = [point_level; lastlayer];
                end
            end
    end
end

% get final result
locs = [xindex, yindex, point_level];            
end