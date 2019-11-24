% Praneeth Medepalli
% ECE 301: Image Low Pass Filter
% April 1, 2019
 
% Extract the individual red, green, and blue color values as matrices
imData = imread('imageTest2.jpg');
R = imData(:,:,1); 
G = imData(:,:,2); 
B = imData(:,:,3);

colorMatrix = ( double( R  + G  + B ) / 3) .^ (1);
% Convert to grayscale
grayImage = rgb2gray(imData);

% Calculate mean and std dev.
M = mean2(grayImage);
S = std2(grayImage);

% Color testing
MR = mean2(R);
SR = std2(R);
MG = mean2(G);
SG = std2(G);
MB = mean2(B);
SB = std2(B);
MC = mean2(colorMatrix);
SC = std2(colorMatrix);

% Adjust cutoff
N = 1.3; % Number of std dev above mean
NR = 2;
NG = 2;
NB = 2;
NC = 2;

% Pixel
paramPix = 200;

% Obtain dimensions of image in # of pixels
[picHeight,picLength] = size(grayImage);
 
% Create new matrices for filtered image
rNew = zeros(picHeight,picLength);
gNew = zeros(picHeight,picLength);
bNew = zeros(picHeight,picLength);
rNew2 = zeros(picHeight,picLength);
gNew2 = zeros(picHeight,picLength);
bNew2 = zeros(picHeight,picLength);
grayNew = zeros(picHeight,picLength);
grayNew2 = zeros(picHeight,picLength);

% Iterate over every pixel
for r = 1:picHeight
    for c = 1:picLength
        
        % Store values over certain cutoff - grayscale
        if grayImage(r,c) > (M + N*S)
            grayNew(r,c) = grayImage(r,c);
        else
            grayNew(r,c) = 0;
        end
 
        % If exceeds a certain brightness, store - grayscale
        if grayImage(r,c) > paramPix
            grayNew2(r,c) = 255; % Scale up to white
        else
            grayNew2(r,c) = 0;
        end
        
        % Store values over certain cutoff - red
%         if R(r,c) > (MR + NR*SR)
%             rNew(r,c) = R(r,c);
%         else
%             rNew(r,c) = 0;
%         end
%         
%         % Store values over certain cutoff - green
%         if G(r,c) > (MG + NG*SG)
%             gNew(r,c) = G(r,c);
%         else
%             gNew(r,c) = 0;
%         end
%         
%         % Store values over certain cutoff - blue
%         if B(r,c) > (MB + NB*SB)
%             bNew(r,c) = B(r,c);
%         else
%             bNew(r,c) = 0;
%         end 
        
        % Store values over certain cutoff - red
        if R(r,c) > (MC + NC*SC)
            rNew(r,c) = R(r,c);
        else
            rNew(r,c) = 0;
        end
        
        % Store values over certain cutoff - green
        if G(r,c) > (MC + NC*SC)
            gNew(r,c) = G(r,c);
        else
            gNew(r,c) = 0;
        end
        
        % Store values over certain cutoff - blue
        if B(r,c) > (MC + NC*SC)
            bNew(r,c) = B(r,c);
        else
            bNew(r,c) = 0;
        end
    end
end
 
% Recombine separate color matrices into an RGB image.
%imRecons = cat(3, Rnew, Gnew, Bnew);

% Create new image
imDataNew = grayNew;
imDataNew2 = grayNew2;
imDataNew3(:,:,1) = rNew;
imDataNew3(:,:,2) = gNew;
imDataNew3(:,:,3) = bNew;

% Write data to file and compare to original picture
imwrite(imData,'testInput.png');
imwrite(grayImage,'testInput2.png');
imwrite(imDataNew,'Method1.png');
imwrite(imDataNew2,'Method2.png');
imwrite(imDataNew3,'testOutput3.png');