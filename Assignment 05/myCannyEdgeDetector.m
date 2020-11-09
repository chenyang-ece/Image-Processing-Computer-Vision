% Chen Yang, Username:cyang3, UFID:552109967, 
% ECE Department,University of Florida
% Please call this function by [myCannyEdgeDetector(imread('name of img'),k,sigma,low_threshold,high_threshold)]
% This function can only receive grayscale image for input.
function edge_img = myCannyEdgeDetector(img,k,sigma,T_Low,T_High)
%% STEP 0 Read and Load
% figure,imshow(img),title('Original Image');
img = double (img);
%% STEP 1 Compute Gradient:Magnitude and Direction at Each Pixel
% Generate a normal Gaussian filter
gaussian = fspecial('gaussian',[k k],sigma);
% Smooth the image with Gaussian filter
img_smooth = conv2(img,gaussian,'same');
% Initialization for gradient computing mask
Gx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
Gy =  [1, 2, 1; 0, 0, 0; -1, -2, -1];
% Convolute the smoothed image by x and y filter 
x_grad = conv2(img_smooth, Gx, 'same');
y_grad = conv2(img_smooth, Gy, 'same');
% Compute magnitude
magnitude = (x_grad.^2)+(y_grad.^2);
magnitude = sqrt(magnitude);
% subplot(2,2,1),imshow(uint8(magnitude)),title('Gradient Magnitude'); %XXXXXXXXXXXXXXXXXXXXXXXXXXX
% Compute directions and convert it to degrees
dir = atan2(y_grad,x_grad);
dir_degree = dir*180/pi;
% subplot(2,2,2),imshow(dir_degree),title('Gradient Phase'); % XXXXXXXXXXXXXXXXXXXXXXXXXX

% For each pixel, adjust those negative phase to positive
[h,w] = size(img_smooth);
for i=1:h
    for j=1:w
        if (dir_degree(i,j)<0) 
            dir_degree(i,j)=360+dir_degree(i,j);
        end;
    end;
end;
% Adjust the pixels' direction to the nearest 0, 45, 90, 138 degree
% In order to make algorithm perform better in the edge linking process
for i = 1  : h
    for j = 1 : w
        if ((dir_degree(i, j) >= 0 ) && (dir_degree(i, j) < 22.5) || (dir_degree(i, j) >= 157.5) && (dir_degree(i, j) < 202.5) || (dir_degree(i, j) >= 337.5) && (dir_degree(i, j) <= 360))
            dir_degree(i, j) = 0;
        elseif ((dir_degree(i, j) >= 22.5) && (dir_degree(i, j) < 67.5) || (dir_degree(i, j) >= 202.5) && (dir_degree(i, j) < 247.5))
            dir_degree(i, j) = 45;
        elseif ((dir_degree(i, j) >= 67.5 && dir_degree(i, j) < 112.5) || (dir_degree(i, j) >= 247.5 && dir_degree(i, j) < 292.5))
            dir_degree(i, j) = 90;
        elseif ((dir_degree(i, j) >= 112.5 && dir_degree(i, j) < 157.5) || (dir_degree(i, j) >= 292.5 && dir_degree(i, j) < 337.5))
            dir_degree(i, j) = 135;
        end;
    end;
end;

%% STEP 2 Non-Max Suppression
G_localmax = zeros(h,w);
for i=2:h-1
    for j=2:w-1
        if (dir_degree(i,j)==0)
            G_localmax(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i,j+1), magnitude(i,j-1)]));
        elseif (dir_degree(i,j)==45)
            G_localmax(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j-1), magnitude(i-1,j+1)]));
        elseif (dir_degree(i,j)==90)
            G_localmax(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j), magnitude(i-1,j)]));
        elseif (dir_degree(i,j)==135)
            G_localmax(i,j) = (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j+1), magnitude(i-1,j-1)]));
        end;
    end;
end;
G_localmax = G_localmax.*magnitude;

%% STEP 3 Threshold Computing and Edge Linking
% Thresholding
T_Low = T_Low * max(max(G_localmax));
T_High = T_High * max(max(G_localmax));
T_res = zeros (h, w);
for i = 1  : h
    for j = 1 : w
        if (G_localmax(i, j) < T_Low)
            T_res(i, j) = 0;
        elseif (G_localmax(i, j) > T_High)
            T_res(i, j) = 1;
        % Using 8-connected method and perform edge linking
        elseif ( G_localmax(i+1,j)>T_High || G_localmax(i-1,j)>T_High || G_localmax(i,j+1)>T_High || G_localmax(i,j-1)>T_High || G_localmax(i-1, j-1)>T_High || G_localmax(i-1, j+1)>T_High || G_localmax(i+1, j+1)>T_High || G_localmax(i+1, j-1)>T_High)
            T_res(i,j) = 1;
        end;
    end;
end;
contour_img = uint8(T_res.*255);
%Show final edge detection result
% subplot(2,2,3),imshow(contour_img),title('Thresholded Gradient Magnitude(Contour Lines)'); % XXXXXXX


% Image recovery
edge_img = zeros(h,w,3);
edge_img(:,:,1) = img;
edge_img(:,:,2) = img;
edge_img(:,:,3) = img;

for i = 1:h
    for j =1:w
        if contour_img(i,j) == 255;
            edge_img(i,j,1) = 0;
            edge_img(i,j,2) = 0;
            edge_img(i,j,3) = 255;
        end
    end
end
% subplot(2,2,4),imshow(uint8(edge_img)),title('After Edge Detection');
figure,imshow(uint8(edge_img)),title('After Edge Detection'),xlabel('In order to observe more clearly, please maximize the picture interface.');
end

