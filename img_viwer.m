clear all;
close all;
filelst = dir(fullfile('cnned/input', '*.png'))
ssim_array = size(length(filelst));
ssim_index = size(length(filelst));

for i = 1:length(filelst)
    filename = "cnned/input/" + filelst(i).name;
    i_img_data = imread(filename);
    i_img_data = imresize(i_img_data, [141, 110]);
    filename = "cnned/output/" + filelst(i).name;
    o_img_data = imread(filename);
    o_img_data = imresize(o_img_data, [141, 110]);
    figure(1);
    mesh(i_img_data);
    figure(2);
    mesh(o_img_data);

    K = [0.03 0.03];
    window = ones(10);
    L = 100;
    [score , ssim_map] = ssim(i_img_data, o_img_data, K, window, L);
    %figure(i);
    imshow(ssim_map,[]);
    ssim_array(i) = score; 
    ssim_index(i) = i;
    
end

figure(4);
plot(ssim_array);
