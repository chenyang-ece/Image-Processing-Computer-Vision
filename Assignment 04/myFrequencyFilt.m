% Chen Yang, Username:cyang3, UFID:552109967, 
% ECE Department,University of Florida
% Please call this function by [myFrequencyFilt((imread('imagename.png') ,filtername)]
% This function can only receive grayscale image for input.
function conv_img = myFrequencyFilt(img,filter)
% Read and Load the Image 
img=double(img);
[m,n] = size(img);
% Compute DFT of image and filter
fft_img=fft2(img);
fft_filter = fft2(filter,m,n);
subplot(1,3,1),imshow(uint8(fft_img)),title('DFT Image before Filtering')
% Compute convolution using multiplication in Frequency domain
conv_img = ifft2(fft_img.*fft_filter);

% Using the algorithm in the homework1 to shift the DFT image
mid = floor(size(fft_img)/2);
fft_img = fft_img([mid(1)+1:end,1:mid(1)],[mid(2)+1:end, 1:mid(2)]);
% Computing the Image Magnitude with the Obtained shifted Imaage above
magnitude=log(1+abs(fft_img));
% Compute Phase of the Image
phase=(1+angle(fft_img)/pi)*255;
% Plot the result
subplot(1,3,2),imshow(magnitude,[]),title('Magnitude of Input Image');
subplot(1,3,3),imshow(phase,[]),title('Phase of Input Image');
figure
imshow(uint8(conv_img)),title('Filtered Image');

end