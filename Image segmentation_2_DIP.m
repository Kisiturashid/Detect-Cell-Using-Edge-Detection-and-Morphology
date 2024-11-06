%Step 1
% Load the image
imagePath = 'Cell.tif'; % make the sure image is the same folder with Matlab code
img = imread(imagePath);
imshow(img);

% Convert the image to grayscale if it's not already 
% the image is coverted to gray because edge detection identifies the contours in the grayscale image.
if size(img, 3) == 3
    imgGray = rgb2gray(img); % converting the image from rbg to gray if true 
else
    imgGray = img;
end

[~, threshold] = edge(imgGray, 'Prewitt');
adjustFactor = .5;
binaryMask = edge(imgGray,'Prewitt', threshold * adjustFactor );
figure, imshow(binaryMask);, 
title('binary mask  for Prewitt');
% Step 2: Create Linear Structuring Elements for Dilation
structEle_90 = strel('line', 3, 90);  % Vertical line structuring element (3 pixels)
structEle_0 = strel('line', 3, 0);    % Horizontal line structuring element (3 pixels)

% Step 3: Dilate the Image
% Dilate the binary gradient mask with both structuring elements
binaryMask_dil = imdilate(binaryMask, [structEle_90 structEle_0]);

% Display the dilated gradient mask
figure;
imshow(binaryMask_dil);
title('Dilated Mask');
%In step 4
binaryMask_fill = imfill(binaryMask_dil, 'holes');
imshow(binaryMask_fill)
title('filled Binary Image ')
%In step 5
binaryMaskbord = imclearborder(binaryMask_fill, 4);
figure, imshow(binaryMaskbord), title('Binary Image without Border Objects');
% In step 6
seD = strel('diamond', 1);
binaryMaskfinal = imerode(binaryMaskbord, seD);
binaryMaskfinal = imerode(binaryMaskfinal, seD);
imshow(binaryMaskfinal)
title('Segmented Image');
% In step 6
seD = strel('diamond', 1);
binaryMaskfinal = imerode(binaryMaskbord, seD);
binaryMaskfinal = imerode(binaryMaskfinal, seD);
imshow(binaryMaskfinal)
title('Smoothed Segmented Image');

% In step 7
imshow(labeloverlay(imgGray,binaryMaskfinal))
title('Mask Over Original Image')











