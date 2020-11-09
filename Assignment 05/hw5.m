% Student Name: Chen Yang
% Student Username: cyang3
% hw5 testing code

%% Read Images - Do not edit, you may assume all programs and files are in the same folder
img1 = imread('img1.pgm');
img2 = imread('img2.pgm');
img3 = imread('img3.pgm');

%% Run myCannyEdgeDetector - edit only parameters in myCannyEdgeDetector
edges1 = myCannyEdgeDetector(img1,5,2,0.085,0.1);
edges2 = myCannyEdgeDetector(img2,3,0.5,0.075,0.175);
edges3 = myCannyEdgeDetector(img3,3,0.5,0.075,0.175);

% % Run myHarrisCornerDetector - edit only parameters in myHarrisCornerDetector
corners1 = myHarrisCornerDetector(img1,5,1,0.04);
corners2 = myHarrisCornerDetector(img2,5,1,0.04);
corners3 = myHarrisCornerDetector(img3,5,1,0.04);