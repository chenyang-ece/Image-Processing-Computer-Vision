% Chen Yang, Username:cyang3, UFID:552109967, 
% ECE Department,University of Florida
% Please call this function by [variable = mySpatialFlit(imread('imagename.png') ,filtername)]
% This function can only receive grayscale image for input.
function conv_img = mySpatialFilt(img,filter)
%% Load and Initialization
img = double(img); 
[m,n] = size(img);% Read the size of image
[t,r] = size(filter); % Read the size of filter
filt_size = max(t,r);
d = floor(filt_size/2);          % Compute the thickness that we need to pad to each boundaries
padd_img = zeros(m+2*d,n+2*d);   % Initialize a new image for padding preparation
conv_img = zeros(m,n);           % Initialize a new image for convolution preparation
%% Pad the image
% We divided the section that need to be padded into 5 part
% 1. Pad the original image to the centre part of new padded image
padd_img(d+1:m+d,d+1:n+d) = img;    
% 2. Pad the top boundary to the new location of paddded image
top = img(1:d,:);
padd_img(1:d,d+1:n+d)= top(end:-1:1,:) ;
% 3. Pad the bottom part
bot = img(m-d+1:m,:);
padd_img(m+d+1:m+2*d,d+1:n+d)=bot(end:-1:1,:) ;
% 4. Pad the image obtained above, reallocate its left part to the
% left boundary
left = padd_img(:,d+1:2*d);
padd_img(:,1:d)=left(:,end:-1:1);
% 5. Pad the right part to the right boundary.
right = padd_img(:,n+1:d+n);
padd_img(:,n+d+1:2*d+n)=right(:,end:-1:1);
%% Compute Convolution 
for i = 1:m
    for j = 1:n
        conv_img(i,j) = sum(sum(filter.*(padd_img(i:i+t-1,j:j+r-1))));
    end
end
%% Plot the Result
subplot(1,3,1),imshow(uint8(img)),title('The Original Image');
subplot(1,3,2),imshow(uint8(padd_img)),title('Mirror Reflection Padding');
subplot(1,3,3),imshow(uint8(conv_img)),title('Image after Convolution');
end
