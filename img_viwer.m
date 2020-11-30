clear all;
close all;

img_data = imread("processed_data\comp_csf\csfed_Pixel2_No4_032_Comp_4_g.jpeg");
figure(1);
imshow(img_data,[]);
figure(2);
mesh(img_data);