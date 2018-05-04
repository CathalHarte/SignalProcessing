stars = imread('star.jpg');
twinkle = imread('cross.jpg');
stars = stars(:,:,1);
stars = stars > 100;
pad = zeros(size(stars));
twinkle = twinkle(1:end/2,1:end/2,1);
twinkle = downsample(twinkle, 8);
twinkle = downsample(twinkle', 8)';
figure
imshow(twinkle, []);
%%
[ y, x ] = size(twinkle);
pad(1:y,1:x) = twinkle;
figure
imshow(stars, []);
%%

stars_fft = fft2(stars);
twinkle_fft = fft2(pad);
out_fft = stars_fft.*twinkle_fft;
out = ifft2(out_fft);
out = out.^(4/5);
figure
imshow(out, []);