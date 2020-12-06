clear all;
close all;

filelst = dir(fullfile('csf_filtered/New_DoG_CSFed/G/I3', '*.png'))
for i = 1:length(filelst)
    filename = "csf_filtered/New_DoG_CSFed/G/I3/" + filelst(i).name;
    img_data = imread(filename);
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
    filename = "csf_filtered/New_DoG_CSFed/Stretched/" + filelst(i).name
    imwrite(img_data, filename);
    
end