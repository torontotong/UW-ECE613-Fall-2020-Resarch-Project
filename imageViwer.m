clear all;
close all;
%filelst = dir(fullfile('processed_data/I1', '*.png'))

%for i = 1:length(filelst)
   % filename = "processed_data/comp/" + filelst(i).name;
    filename = "cnned\input\" + "r_Pixel2_No4_240_comp_1_g.jpeg";
    i_img_data = imread(filename);
    figure(1);
    mesh(i_img_data);
    filename = "cnned\output\" + "r_Pixel2_No4_240_comp_1_g.jpeg";
    o_img_data = imread(filename);
    figure(23);
    mesh(o_img_data);
    
    K = [0.03 0.03];
    window = ones(8);
    L = 255;
    [score , ssim_map] = ssim(i_img_data, o_img_data, K, window, L);
    figure(3);
    mesh(ssim_map);

    filename = "cnned\input\" + "r_Pixel2_No4_128_comp_1_g.jpeg";
    i_img_data = imread(filename);
    figure(4);
    mesh(i_img_data);
    filename = "cnned\output\" + "r_Pixel2_No4_128_comp_1_g.jpeg";
    o_img_data = imread(filename);
    figure(5);
    mesh(o_img_data);
    
    K = [0.03 0.03];
    window = ones(8);
    L = 255;
    [score , ssim_map] = ssim(i_img_data, o_img_data, K, window, L);
    figure(6);
    mesh(ssim_map);
    
%end