clc
clear
imData = imread('imageTest2.jpg');

I = rgb2gray(imData);
BW1 = edge(I,'Canny');
BW2 = edge(I,'Prewitt');
BW3 = edge(I,'Roberts');
BW4 = edge(I,'log');
BW5 = edge(I,'zerocross');
BW6 = edge(I,'approxcanny');
BW7 = imfill(BW3,'holes');
%imshowpair(BW1,BW2,BW3, 'montage');
imwrite(BW1,'testOutput5.png');
imwrite(BW2,'testOutput6.png');
imwrite(BW3,'Method3.png');
imwrite(BW4,'testOutput8.png');
imwrite(BW5,'testOutput9.png');
imwrite(BW6,'testOutput10.png');
imwrite(BW7,'testOutput11.png');