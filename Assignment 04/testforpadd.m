img = imread('escher.png');
img = double(img); 
filter = ones(1000);
[m,n] = size(img);% Read the size of image
[t,r] = size(filter); % Read the size of filter
filt_size = max(t,r);
d = floor(filt_size/2);          % Compute the thickness that we need to pad to each boundaries
padd_img = zeros(m+2*d,n+2*d);   % Initialize a new image for padding preparation
conv_img = zeros(m,n);           % Initialize a new image for convolution preparation
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

imshow(uint8(padd_img))
title('test for 1000 mirror reflection')