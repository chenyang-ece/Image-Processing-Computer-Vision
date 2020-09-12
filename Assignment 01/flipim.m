function [O]=flipim(I)
%This function only applies to grayscale images and RGB images. Cannot flip the images with channel# >3.
%Please call this function by [flipim(imread('name of image'));]

% Read the original matrix parameters.
width = size(I,2);
height = size(I,1);
channel = size(I,3);

% Reallocate the first quadrant of the new matrix.
O (1:height/2,1:width/2,:)=I((height/2)+1:height,(width/2+1):width,:);

% Reallocate the second quadrant of the new matrix.
O (1:height/2,(width/2+1):width,:)=I(height/2+1:height,1:(width/2),:);

% Reallocate the third quadrant of the new matrix.
O ((height/2)+1:height,1:width/2,:)=I(1:height/2,(width/2)+1:width,:);

% Reallocate the fourth quadrant of the new matrix.
O ((height/2)+1:height,(width/2+1):width,:)=I(1:height/2,1:(width/2),:);

% Display the comparison chart of the original image and the output image.
subplot(1,2,1)
imshow(I);title('Before the Flipim '); 
xlabel(['Size (Input Image): ',num2str(height),'*',num2str(width),'*',num2str(channel)]); % Show the size of the original image.

subplot(1,2,2)
imshow(O);title('After the Flipim');
xlabel(['Size (Output Image): ',num2str(size(O,1)),'*',num2str(size(O,2)),'*',num2str(size(O,3))]); % Show the size of the new image.


 
