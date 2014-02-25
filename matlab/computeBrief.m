% Compute BRIEF descriptors for the detected keypoints
% Inputs:
% im - a grayscale image with values from 0 to 1
% locs - keypoints locations returned by DoG detector
% levels - the levels of the pyramid where the blur at each level is
% compareX - test pattern pairs
% compareY - test pattern pairs
function [locs, desc] = computeBrief(im, locs, levels, compareX, compareY)

sigma0 = 1;
k = sqrt(2);
patchWidth = 9;
halfWidth = ceil(patchWidth/2);
patchSize = [patchWidth, patchWidth];
number = 0;

desc = zeros(length(locs), length(compareX));
newlocs = zeros(size(locs));

for index = 1: length(locs)
    x = locs(index, 1);
    y = locs(index, 2);
    level = locs(index, 3);
    
    % check for points that are in the boundary
    if x > 4 && x <= size(im, 1)-4 && y > 4 && y <= size(im,2)-4
        number = number + 1;
        newlocs(number, :) = locs(index, :);
        
        for i = 1:length(compareX)
            [x1, y1] = ind2sub(patchSize, compareX(i));
            [x2, y2] = ind2sub(patchSize, compareY(i));
            
            %compute the BRIEF descriptor
            if im(x+x1-halfWidth, y+y1-halfWidth, 1) < im(x+x2-halfWidth, y+y2-halfWidth, 1)
                desc(number, i) = 1;
            else
                desc(number, i) = 0;
            end
        end
        
    end
end

locs = newlocs(1:number, :);
desc = desc(1:number, :);
end