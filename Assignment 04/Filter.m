clc
clear
%% Gaussian 
img = imread('escher.png');
filter = fspecial('gaussian',[403 403],(403/6))
tic
conv = myFrequencyFilt(img,filter);
toc
figure
%% Separable
% img = imread('escher.png');
% sep1 = fspecial('gaussian',[11 1],(11/6))
% sep2 = fspecial('gaussian',[1 11],(11/6))
% tic
% conv1 = myFrequencyFilt(img,sep1);
% toc
% figure
% tic
% conv2 = myFrequencyFilt(conv1,sep2);
% toc
%% Median
img = imread('escher.png');
tic
Y3=medfilt2(img,[403 403]); 
figure,imshow(Y3),title('median result with matlab toolbox');
toc




