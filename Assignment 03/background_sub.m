% Chen Yang, Username:cyang3, UFID:552109967, 
% ECE Department,University of Florida
% Please call this function by [ background_sub('PeopleWalking.mp4'); ]
function background_sub(videoname)

% Read the video and load the parameter
video = VideoReader(videoname);
[height,width,channel] = size(read(video,1));

% Initialize parameter and set the threshould value
whole = zeros(height,width);
th = 80; % Set the threshold value to 80

% Load the first 100 frames of video
for i = 1:100

    frame = double(read( video, i )); % Read the video frames as images
    r = frame( :, :, 1 ); % Split the red channel from the rgb images
    g = frame( :, :, 2 ); % Split the green channel from the rgb images
    b = frame( :, :, 3 ); % Split the blue channel from the rgb images
    
    frame = 1/4 * (r + 2*g + b ); % Convert rgb into grayscale using 1/4(r+2g+b)
    whole = whole + frame; % Add the cumputed grayscale image of each iteration to sum 
    
end

% Compute the average image and plot it
average = 0.01 * whole ; 
imshow(uint8(average));
title('The Average Image of the First 100 Frames')



for j = [1,25,50,75,100]
    % Load the 1st, 25th, 50th, 75th, 100th frame of video as rgb image
    frame = double(read(video,j));
    figure
    
    % Split the three channels from the rgb image
    r = double(frame(:,:,1));
    g = double(frame(:,:,2));
    b = double(frame(:,:,3));
    
    % Convert rgb into grayscale using algorithm 1/4(r+2g+b)
    frame = 1/4 * (r + 2*g +b);
    
    % Plot the original image from grayscale video
    subplot(2,1,1)
    imshow(uint8(frame))
    title([int2str(j),'th Frame of Grayscale Video'])
    
    % Compute image after substraction using absolute difference
    comp = abs(frame - average);
    comp(comp>=th) = 255; % Adjust the intensity greater than or equal to threshold to 255
    comp(comp<th) = 0; % Adjust the intensity less than threshold to 0
    
    % Plot the image after substraction and thresholding 
    subplot(2,1,2)
    imshow(uint8(comp));
    title(['Processed Result of Frame ',int2str(j),' with Threshold Value: ',int2str(th)])  
    
    
    
end

end
