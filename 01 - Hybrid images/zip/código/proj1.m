function proj1()

%% Setup
% Read images and convert to floating point format
image1 = im2single(imread('../data/dog.bmp'));
image2 = im2single(imread('../data/cat.bmp'));

% For your write up, there are several additional test cases in 'data'. 
% Feel free to make your own, too (you'll need to align the images in a 
% photo editor such as Photoshop).
% The hybrid images will differ depending on which image you
% assign as image1 (which will provide the low frequencies) and which image
% you assign as image2 (which will provide the high frequencies)

%% Hybrid Image Construction
% cutoff_frequency is the standard deviation, in pixels, of the Gaussian 
% blur that will remove high frequencies. You may tune this per image pair 
% to achieve better results.
%
cutoff_frequency = 7;
[hybrid_image,low_frequencies,high_frequencies] = gen_hybrid_image( image1, image2, cutoff_frequency );

%% Visualize and save outputs
figure(1); imshow(low_frequencies);
figure(2); imshow(high_frequencies + 0.5);
vis = vis_hybrid_image(hybrid_image);
figure(3); imshow(vis);
imwrite(low_frequencies, 'low_frequencies.jpg', 'quality', 95);
imwrite(high_frequencies + 0.5, 'high_frequencies.jpg', 'quality', 95);
imwrite(hybrid_image, 'hybrid_image.jpg', 'quality', 95);
imwrite(vis, 'hybrid_image_scales.jpg', 'quality', 95);
