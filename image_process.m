% Praneeth Medepalli
% ECE 301: Image Low Pass Filter
% April 1, 2019
clc
clear
% Extract the individual red, green, and blue color values as matrices
imData = imread('imageF.jpg');
grayImage = rgb2gray(imData);

% Filter kernel
kernel = [0, -1, 0; -1, 5, -1; 0, -1, 0];

% Obtain dimensions of image in # of pixels
[picHeight,picLength] = size(grayImage);
 
% Create new matrices for filtered image
grayNew = zeros(picHeight,picLength);

% Initialize pixel value counters
numPix = 0;
pixval = 0;
 
% (Square window length - 1) / 2 (# of pixels)
windowSize = (3 - 1) / 2;
 
% Iterate over every pixel
for r = 1:picHeight
    for c = 1:picLength
 
        % Initialize pixel value counters
        numPix = 0;
        
        pixelGray = 0;
        
        % Assign bounds of window to iterate over
        leftCol = c - windowSize;
        rightCol = c + windowSize;
        topRow = r - windowSize;
        botRow = r + windowSize;
 
 
        % Check for edge cases (out of bounds)
        if leftCol < 1
            leftCol = 1;
        end
 
        if rightCol > picLength
            rightCol = picLength;
        end
 
        if topRow < 1
            topRow = 1;
        end
 
        if botRow > picHeight
            botRow = picHeight;
        end
 
        % Iterate over window to find average pixel value
        for row = topRow:botRow
            for col = leftCol:rightCol
                tempR = row - topRow + 1;
                tempC = col - leftCol + 1;
                
                pixelGray = pixelGray + double(grayImage(row,col))*kernel(tempR,tempC);
                
                
%                 disp(grayImage(row,col));
%                 disp(kernel(tempR,tempC));
%                 disp(pixelGray);
            end
        end
        
        grayNew(r, c) = pixelGray;
        %disp(grayNew(r, c));
    end
end
 
% Test to make sure original and reconstructed image are identical

imData = uint8(grayNew);
% Write data to file and compare to original picture
imwrite(imData,'testOutput4.png');
disp('done');
