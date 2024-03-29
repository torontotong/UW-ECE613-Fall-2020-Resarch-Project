clear all;
close all;

%csv_data = csvread("Data/B_300_I0_PsdLum.csv");
img_data = csvread("Data/LuminanceData/B_200_I3_PsdLum.csv");
[row,col] = size(img_data);
% Full contrast stretch 
hist_equal_fcs_img = zeros(row,col);
min_r = double(min(img_data(:)));
max_r = double(max(img_data(:)));
stretched = double(img_data-min_r) * double(255) / double(max_r-min_r);
hist_equal_fcs_img = round(stretched);
img_data = uint8(hist_equal_fcs_img);
figure(2);
imshow(img_data,[]);
figure(3);
mesh(img_data);
res_img = uint8(CSFfilter(img_data));
figure(4);
imshow(res_img,[]);
figure(5);
mesh(res_img);


function res = CSFfilter(IM)
% function res = CSFfilter(IM) %
% This function is filter input image IM with a CSF (DoG).
% IM – input image;
% res – filtered image.
f0 = 15.3870;
f1 = 1.3456;
a = 0.7622;

[row,col] = size(IM);
[u,v] = freqspace([row,col],'meshgrid'); % This line determines the conversion.

HH = row; LL = col;
% viewing distance d1
% HH = row/2; LL = col/2;
% viewing distance d2
%HH = row/4; LL = col/4; 
% viewing distance d3
%HH = row/8; LL = col/8;
u = LL*u; v = HH*v;
r = sqrt(u.^2 + v.^2);
theta_G = exp(-(r/f0).^2)-a*exp(-(r/f1).^2); % DoG filter
fim = ifft2(ifftshift(fftshift(fft2(IM)).*theta_G));
res = fim;
end

