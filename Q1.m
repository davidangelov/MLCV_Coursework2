A = imread('cat.png');
cluster_num = 10;
X = [0.25,0.75;0.25,0.25;0.75,0.25;0.75,0.75];

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

[idx,C] = kmeans(RGB_vector,cluster_num,'MaxIter',100);
figure(3);
scatter3(RGB_vector(idx==1,1),RGB_vector(idx==1,2),RGB_vector(idx==1,3),'.', 'MarkerFaceColor', rand(1,3));
if cluster_num > 1
hold on
    for i = 2:cluster_num
        scatter3(RGB_vector(idx==i,1),RGB_vector(idx==i,2),RGB_vector(idx==i,3),'.', 'MarkerFaceColor',rand(1,3));
    end;
end;
% scatter3(RGB_vector(idx==2,1),RGB_vector(idx==2,2),RGB_vector(idx==2,3),'.','MarkerFaceColor',[0 .75 .75]);
% scatter3(RGB_vector(idx==3,1),RGB_vector(idx==3,2),RGB_vector(idx==3,3),'.','MarkerFaceColor',[.75 .75 0]);
scatter3(C(:,1),C(:,2),C(:,3),'kx')
hold off
