% Chen Yang, Username:cyang3, UFID:552109967, 
% ECE Department,University of Florida
% Please call this function by [myHarrisCornerDetector(imread('name of img'),k,sigma)]
% This function can only receive grayscale image for input.
function corner_I =myHarrisCornerDetector(img,k,sigma,a)
% Harris corresponding parameter, the general value range is 0.04-0.06, and 0.04 is used in this function

img=double(img);
% Compute gradient of both x and y orientations 
% Initialization for gradient computing mask
Gx=[1,-1;1,-1];
Gy=[-1,-1;1,1];
Ix=filter2(Gx,img);
Iy=filter2(Gy,img);
%Calculate the product of the gradients in both x and y directions
Ix2=Ix.^2;
Iy2=Iy.^2;
Ixy=Ix.*Iy;
% Use Gaussian weighting function to weight the gradient product
gaussian=fspecial('gaussian',[k,k],sigma);
IX2=filter2(gaussian,Ix2);
IY2=filter2(gaussian,Iy2);
IXY=filter2(gaussian,Ixy);
% Calculate the Harris response value of each pixe
[height,width]=size(img);
R=zeros(height,width);
% Harris response value at pixel (i, j)
for i=1:height
    for j=1:width
        M=[IX2(i,j) IXY(i,j);IXY(i,j) IY2(i,j)];
        R(i,j)=det(M)-a*(trace(M))^2;
    end
end

% subplot(1,2,1), imshow(uint8(R)),title('Harris Response before Non-Maximum Suppression')

% Remove the Harris value of the small threshold
Rmax=max(max(R));
% Thresholding 
t=0.01*Rmax;
for i=1:height
    for j=1:width
        if R(i,j)<t
            R(i,j)=0;
        end
    end
end

% Perform non-maximum suppression
corner_peaks=imregionalmax(R);%imregionalmax对二维图片，采用8领域（默认，也可指定）查找极值，三维图片采用26领域,极值置为1，其余置为0
% Show the extracted Harris corner points and convert the result to RGB 
corner_I = zeros(height,width,3);
corner_I(:,:,1) = img;
corner_I(:,:,2) = img;
corner_I(:,:,3) = img;
[posr,posc]=find(corner_peaks==1);
% According to the requirement, change those corner points to red (255,0,0)
for i = 1: length(posr)
    w = posr(i);
    e = posc(i);
    corner_I(w,e,1)= 255;
    corner_I(w,e,2)= 0;
    corner_I(w,e,3)= 0;
end
num = max(size(posr));   % Get the number of corner points
% subplot(1,2,2),
figure,imshow(uint8(corner_I)),title(['After Corner Detection, the Number of Corner is : ',int2str(num)]),xlabel('In order to observe more clearly, please maximize the picture interface.');
% In order to make the corner points more clear to view, 
% use matlab tools to square those points
hold on
for i=1:length(posr)
    plot(posc(i),posr(i),'r.');
end
end