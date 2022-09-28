function [hybrid_image,low_frequencies,high_frequencies] = gen_hybrid_image_fft( image1, image2, cutoff_frequency )
pkg load image;
% Inputs:
% - image1 -> The image from which to take the low frequencies.
% - image2 -> The image from which to take the high frequencies.
% - cutoff_frequency -> The standard deviation, in pixels, of the Gaussian 
%                       blur that will remove high frequencies.
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the high frequencies from image1 by blurring it. The amount of
% blur that works best will vary with different image pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
low_frequencies = [];

figure, imshow(image1);
b = padarray(image1, size(image1), "zeros", "post");
c = im2double(b(:,:,1:3));
d = fft2(c);
d = fftshift(d);
figure, imshow(uint8(abs(d)));

[n m o] = size(c);
h = zeros([n,m]);
for i = 1:n
for j = 1:m
h(i,j) = H(i,j,size(c),cutoff_frequency);
end
end
figure, imshow(im2uint8(h));

g = d.*h;

g = ifftshift(g);
at = ifft2(g);
[x y o] = size(image1); % pega o tamanho da imagem 1
atc = at(1:x,1:y,:);  % corta a imagem  com o tamanho da imagem 1

figure, imshow(im2uint8(h)); % mostra a imagem 2 invertida
figure, imshow(low_frequencies = atc);  % resultante em baixa frequencia 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the low frequencies from image2. The easiest way to do this is to
% subtract a blurred version of image2 from the original version of image2.
% This will give you an image centered at zero with negative values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
high_frequencies = [];

tam_img2 = size(image2); % pega o tamanho da imagem 2
img_2_w_0 = padarray(image2, tam_img2, "zeros", "post"); % adiciona zeros a imagem 2
img_2_c_double = im2double(img_2_w_0(:,:,1:3)); % converte a imagem 2 para double
tam_double = size(img_2_c_double); % pega o tamanho da imagem 2 convertida para double
img_fourier = fftshift(fft2(img_2_c_double)); % faz a transformada de fourier da imagem 2 e centraliza

[n m o] = size(img_2_c_double); % pega o tamanho da imagem 2
mat_w_0 = zeros([n,m]); % cria uma matriz de zeros com o tamanho da imagem 2
for i = 1:n  
for j = 1:m 
mat_w_0(i,j) = H(i,j,tam_double,cutoff_frequency); % calculo do filtro 
end 
end

mat_w_0 = imcomplement(mat_w_0); % inverte a imagem 2


img_2_res = img_fourier.*mat_w_0; % multiplica a imagem 2 transformada pelo filtro

trans_inv = ifft2(ifftshift(img_2_res)); % centraliza a imagem 2 invertida e faz a transformada inversa da imagem 2 invertida
[x y o] = size(image1); % pega o tamanho da imagem 1
atc = trans_inv(1:x,1:y,:);  % pega a imagem 2 invertida centralizada

figure, imshow(image2); % mostra a imagem 2
figure, imshow(uint8(abs(img_fourier))); % mostra a imagem 2  da transformada de fourier
figure, imshow(high_frequencies = atc);  % resultante 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine the high frequencies and low frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hybrid_image = abs(low_frequencies + high_frequencies); % combina frequencias

figure, imshow(hybrid_image); % mostra a imagem hibrida

