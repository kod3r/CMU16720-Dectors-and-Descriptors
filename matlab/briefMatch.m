function [matches] = briefMatch(desc1, desc2, ratio)
rows = size(desc1, 1);
columns = size(desc2, 1);
distance = zeros(rows, columns);
matches = zeros(rows+columns, 2);
number = 0;
%compute distance matrix
for i = 1:rows
    vec1 = desc1(i,:);
   
    for j = 1:columns
        vec2 = desc2(j,:);
        distance(i,j) = sum(vec1~=vec2);
    end
end

%get matches
for i = 1:rows
    cur = distance(i, :);
    minvalue = min(cur);
    secondvalue = min(cur(cur~=min(cur)));
    
    if minvalue/secondvalue < ratio
        number = number + 1;
        jindex = find(cur==minvalue,1);
        
        matches(number,1) = i;
        matches(number,2) = jindex;
    end
end

%from another direction
for i = 1:columns
    cur = distance(:, i);
    minvalue = min(cur);
    secondvalue = min(cur(cur~=min(cur)));
    
    if minvalue/secondvalue < ratio
        number = number + 1;
        jindex = find(cur==minvalue,1);
        
        matches(number,1) = jindex;
        matches(number,2) = i;
    end
end

number
matches = matches(1:number,:);
end