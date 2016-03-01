clear;
close all;

A = imread('cat.png');
cluster_num = 2;

red = A(:,:,1);
green = A(:,:,2);
blue = A(:,:,3);

num_element = numel(red);
red_vector = reshape(red, num_element, 1);
green_vector = reshape(green, num_element, 1);
blue_vector = reshape(blue, num_element, 1);

RGB_vector = double([red_vector, green_vector, blue_vector]);

figure(1);
imshow(A);
title('Original Image');

figure(2);
scatter3(red_vector, green_vector, blue_vector, '.');
title 'Data Points Representing Pixels in a RGB Image'

rng(1)

Path_array = zeros(1,cluster_num*3);
[~,C] = kmeans(RGB_vector,cluster_num,'MaxIter', 1, 'Start', 'plus');
iteration_count = 1;

[idx,C1] = kmeans(RGB_vector,cluster_num,'MaxIter',1, 'Start', C);
Path_array(iteration_count, :) = reshape(C.', 1, cluster_num*3);
iteration_count = iteration_count + 1;

while ~isequal(C1,C)
    C = C1;
    [idx,C1] = kmeans(RGB_vector,cluster_num,'MaxIter',1, 'Start', C);
    Path_array(iteration_count, :) = reshape(C.', 1, cluster_num*3);
    iteration_count = iteration_count + 1;
end

figure(3);
scatter3(RGB_vector(idx==1,1),RGB_vector(idx==1,2),RGB_vector(idx==1,3),'.', 'MarkerFaceColor', rand(1,3));
if cluster_num > 1
hold on
    for i = 2:cluster_num
        scatter3(RGB_vector(idx==i,1),RGB_vector(idx==i,2),RGB_vector(idx==i,3),'.', 'MarkerFaceColor',rand(1,3));
    end;
end;
title 'Cluster Assignment'
hold off

figure(4);
title 'Cluster Centroids Iteration and Convergence'
hold on
for i = 0:cluster_num-1
    scatter3(Path_array(:,1+i*3),Path_array(:,2+i*3),Path_array(:,3+i*3),'.')
    line(Path_array(:,1+i*3),Path_array(:,2+i*3),Path_array(:,3+i*3))
end
plot3(Path_array(:,1+i*3),Path_array(:,2+i*3),Path_array(:,3+i*3))
scatter3(C(:,1),C(:,2),C(:,3),'kx')
hold off

%Quantisation
image_size = size(A);

for i = 1:cluster_num
    RGB_vector(idx==i,1) = C(i,1);
    RGB_vector(idx==i,2) = C(i,2);
    RGB_vector(idx==i,3) = C(i,3);
end;

red_Q = reshape(RGB_vector(:,1), image_size(1), image_size(2));
green_Q = reshape(RGB_vector(:,2), image_size(1), image_size(2));
blue_Q = reshape(RGB_vector(:,2), image_size(1), image_size(2));

image_Q = zeros(image_size);

image_Q(:,:,1) = red_Q;
image_Q(:,:,2) = green_Q;
image_Q(:,:,3) = blue_Q;

image_Q = uint8(image_Q);
result = A - image_Q;

figure(5);
imshow(image_Q);
str = sprintf('Quantised Image with %d k-means Clusters',cluster_num);
title(str);

