% Chen Yang, Username:cyang3, UFID:552109967, ECE Department,University of Florida
% This function can only plot myquantize image for grayscale value. 
% If applied to RGB image, the system will report errors.
% Please call this function by [ h=myquantize('name of image . png',num) ]
function output = myquantize (input,quant_num)


% Plot the Original Image
subplot(1,2,1)
imshow(input);title('Original Image¡ý');

input = double(input); % Transform the input matrix into double type.

% First, get the interval, and then set all values of matrix to a special
% lower bound point by using floor, then use the floor result times the
% interval,we can get the output value of desired matrix. Finally set the
% type to interger.
output = uint8(floor(input/(256/quant_num))) * (256/quant_num);


% Plot the Processed Image
subplot(1,2,2)
imshow(output);
title([int2str(quant_num),' Levels Quantized Version ¡ý']);

end
        
        
        
        
        



