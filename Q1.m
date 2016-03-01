A = imread('blackandyellow.png');
cluster_num = 8;

red = A(:,:,1);
green = A(:,:,2);
blue = A(:,:,3);

num_element = numel(red);
red_vector = reshape(red, num_element, 1);
green_vector = reshape(green, num_element, 1);
blue_vector = reshape(blue, num_element, 1);

RGB_vector = double([red_vector, green_vector, blue_vector]);

figure(1);
scatter3(red_vector, green_vector, blue_vector, '.');

figure(2);
imshow(A);

rng(1)

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
hold off

figure(4);
hold on
for i = 0:cluster_num-1
    scatter3(Path_array(:,1+i*3),Path_array(:,2+i*3),Path_array(:,3+i*3),'.')
    %line(Path_array(:,1+i*3),Path_array(:,2+i*3),Path_array(:,3+i*3))
end
plot3(Path_array(:,1+i*3),Path_array(:,2+i*3),Path_array(:,3+i*3))
scatter3(C(:,1),C(:,2),C(:,3),'kx')
hold off


