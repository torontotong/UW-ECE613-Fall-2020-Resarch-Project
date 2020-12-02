clear all;
close all;
filelst = dir(fullfile('processed_data\I1', '*.png'));

for i = 1:length(filelst)
    filename = "processed_data\I1\" + filelst(i).name;
    i_img_data = imread(filename);

    figure(i);
    imshow(i_img_data,[]);
    
end

