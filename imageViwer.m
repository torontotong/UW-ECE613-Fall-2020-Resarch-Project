clear all;
close all;
filelst = dir(fullfile('processed_data/comp', '*.png'))

for i = 1:length(filelst)
    filename = "processed_data/comp/" + filelst(i).name;
    i_img_data = imread(filename);
    figure(i);
    imshow(i_img_data,[]);
    
end