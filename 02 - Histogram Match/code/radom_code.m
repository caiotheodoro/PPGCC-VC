% Code used in 2021/2 class that might help

image1patch = imread('img1_patch.png');
image2patch = imread('img2_patch.png');

red = image1patch(:,:,1); % Canal vermelho
green = image1patch(:,:,2); % Canal verde
blue = image1patch(:,:,3); % Canal azul

[hist1, ~] = imhist(image1patch);
hist_test = hist1 / numel(image1patch);

[hist2, ~] = imhist(image2patch);

sub = hist2 - hist1;
plot(sub);
figure;
plot(abs(sub));
quadrado = sub.^2;
figure;
plot(quadrado);
diff = sum(quadrado);
diff2 = sum(abs(sub));


fplot(@(x) 3*x^2+5*x+10)
x1 = 2;
x2 = 4;
x3 = 5;
y1 = 3*x1^2 + 5*x1 + 10
y2 = 3*x2^2 + 5*x2 + 10
y3 = 3*x3^2 + 5*x3 + 10

A = [x1^2, x1, 1; x2^2, x2, 1; x3^2, x3, 1]
B = [y1; y2; y3]
c = A\B

x1 = 0;
x2 = 127;
x3 = 255;
y1 = 0;
y2 = 200;
y3 = 255;

A = [x1^2, x1, 1; x2^2, x2, 1; x3^2, x3, 1]
B = [y1; y2; y3]
c = A\B



A = zeros(256,1);
for j=1:256
i = j-1;
A(j) = c(1)*i^2+c(2)*i+c(3);
end
A = uint8(A);
figure
plot(A);

figure
imshow(red);
redd = double(red);
redd = redd+1;
figure
imshow(A(redd));


