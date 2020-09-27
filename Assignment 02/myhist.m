%  Chen Yang, Username:cyang3, UFID:552109967, ECE Department,University of Florida
% This function can only plot historgram for grayscale value. 
% If applied to RGB image, the system will report errors.
% Please call this function by [ output = myhist('name_of_image.png') ]
function number  = myhist(Image)

% Read the size of the image
[rows, columns] = size(Image);

% Initialize the number
number = zeros(1, 256);

% Use two for loops to get the value of each pixel
for col = 1 : columns
	for row = 1 : rows
		% Get the intensity value of each pixel.
		pixelValue = Image(row, col);
		% Add 1 because pixelValue zero goes into index 1 and so on.
		number(pixelValue+ 1) = number(pixelValue+1) + 1;
	end
end

% Plot the histogram.
pixelValues = 0 : 255;
bar(pixelValues, number, 'BarWidth', 1, 'FaceColor', 'b');
xlabel('Pixel Values');         % Set the x axis label
ylabel('Number of Occurrences');              % Set the y axis label
xlim([0 255]);                 % Set a limitation for x axis 
title('Histogram ');            % Set the title for the histogram


end
