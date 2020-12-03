clear all;
close all;

filelst = dir(fullfile('LuminanceData', '*.csv'))
%filelst = dir(fullfile('testset', '*.jpeg'))
for i = 1:length(filelst)
    filename = "LuminanceData/" + filelst(i).name;
    img_data = csvread(filename);
    %img_data = rgb2gray(img_data);
    [row,col] = size(img_data);
    % Full contrast stretch 
     hist_equal_fcs_img = zeros(row,col);
     min_r = double(min(img_data(:)));
     max_r = double(max(img_data(:)));
     stretched = double(img_data-min_r).*double(255)./double(max_r-min_r);
     hist_equal_fcs_img = round(stretched);
     img_data = uint8(hist_equal_fcs_img);
    figure(2);
    imshow(img_data,[]);
    filename = "processed_data/" + filelst(i).name + ".png"
    imwrite(img_data, filename);
    %res_img = uint8(CSF_Mannos_Sakrison_Filter(img_data));
    res_img = uint8(CSF_DoG_Filter(img_data));
    %res_img = uint8(CSF_Daly_Filter(img_data));
    %res_img = CSF_Mannos_Sakrison_Filter(img_data);
    hist_equal_res_img = zeros(row,col);
    min_r = double(min(res_img(:)));
    max_r = double(max(res_img(:)));
    stretched = double(res_img-min_r).*double(255)./double(max_r-min_r);
    hist_equal_res_img = round(stretched);
    res_img = uint8(hist_equal_res_img);
    figure(3);
    imshow(res_img,[]);
    filename = "csf_filtered/MS_csfed_" + filelst(i).name + ".png";
    imwrite(res_img, filename);
    
end

function res = CSF_DoG_Filter(IM)
% function res = CSF_DoG_Filter(IM) %
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
theta_G = exp(-(r./f0).^2)-a.*exp(-(r./f1).^2); % DoG filter
fim = ifft2(ifftshift(fftshift(fft2(IM)).*theta_G));
res = fim;
end

function res = CSF_Mannos_Sakrison_Filter(IM)
% IM – input image;
% res – filtered image.
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
temp = 2.6*(0.0192 + 0.144.*r);
theta_G = temp.*exp(-(0.144.*r).^(1.1)); % Mannos Sakrison filter
fim = ifft2(ifftshift(fftshift(fft2(IM)).*theta_G));
res = fim;
end


function res = CSF_Movshon_Filter(IM)
% IM – input image;
% res – filtered image.
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
theta_G = 75.*(r.^0.2).*exp(-0.8.*r); % Movshon filter
fim = ifft2(ifftshift(fftshift(fft2(IM)).*theta_G));
res = fim;
end


function res = CSF_Barton_Filter(IM)
% IM – input image;
% res – filtered image.
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
theta_G = r.*exp(-0.25.*r); % Barton filter
fim = ifft2(ifftshift(fftshift(fft2(IM)).*theta_G));
res = fim;
end

function res = CSF_Daly_Filter(IM)
% IM – input image;
% res – filtered image.
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
first_part = (0.008./(r.^3) + 1).^(-0.2);
last_part = -0.3.*r.*sqrt(1+0.06*exp(0.3.*r));
theta_G = first_part.*1.42.*r.*exp(last_part); % Daly filter
fim = ifft2(ifftshift(fftshift(fft2(IM)).*theta_G));
res = fim;
end


