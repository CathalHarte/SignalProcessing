% I use the gradient as a means to detect edges
% phase correlation with template
% downsampling

clear
close all

% the two things I am interested in
Shanghai = imread('shanghai.jpg');
letter = imread('O.jpg');

% The mask
wallpaper = imread('wallpaper.jpg');

 %Remove excess color info, it's in black and white
Shanghai = Shanghai(:,:,1);
letter = letter(:,:,1);
wallpaper = wallpaper(:,:,1);

Gx = [-1 1]; % Vector for finding gradient
Gy = Gx';
sca = 2; % Scaling factor for downsampling 
% A scaling of 2 will work, but 4 does not

h = fspecial('gaussian',3,3); %3, 20 works

tic % Begin counting, this is the stuff that must be done every time
% Do some pre processing on the picture, to highlight distinct shapes
pic = Shanghai;
    pic = downsample(pic, sca); %Remove every sca row and column
    fIm = downsample(pic', sca)';
    fIm = imfilter(single(fIm), h); % Smooth it
    fImX = conv2(fIm,Gx,'same'); %Get the gradient in the x and y direction
    fImY = conv2(fIm,Gy,'same');
    fIm = (fImX.^2 + fImY.^2).^1/2; % get the 2 norm of the gradient
    fIm = fIm > mean(mean(fIm)); %downsample to black and white, white is an edge
Shanghai_proc = fIm;

% The same must be done for the template, turning it from a black opaque O into an O with two white edges
pic = letter;
    pic = downsample(pic, sca); %Remove every sca row and column
    fIm = downsample(pic', sca)';
    fIm = imfilter(single(fIm), h); % Smooth it
    fImX = conv2(fIm,Gx,'same'); %Get the gradient in the x and y direction
    fImY = conv2(fIm,Gy,'same');
    fIm = (fImX.^2 + fImY.^2).^1/2; % get the 2 norm of the gradient
    fIm = fIm > mean(mean(fIm)); %downsample to black and white, white is an edge
O_proc = zeros(size(fIm));
O_proc(2:end-2, 2:end-2) = fIm(2:end-2, 2:end-2); %Removes the edge effects caused by gradient method

[ y, x ] = size(Shanghai_proc);
O_padded = 2^8*zeros(y,x); % Pad the O so that we can convolve it.
[ y, x ] = size(O_proc);
O_padded(1:y,1:x) = O_proc;

Shanghai_fft = fft2(Shanghai_proc); %Get the Fourier transform of both
O_fft = fft2(O_padded);

% Convolution in the spatial domain is multiplication in the freq domain
% Conjugation in the freq domain is reversal in the time domain
% Correlation of A(x)B(x) is convolution of A(x)B(-x)
R = Shanghai_fft.*conj(O_fft);

% Normalize the output of the correlation so that the max is NOT simply the
% brightest area in the image, but the area with the highest normalized
% correlation
R = R./abs(R);
correls = ifft2(R);

[ypeak, xpeak] = find(real(correls)==max(real(correls(:))));
Shanghai(ypeak*sca:ypeak*sca+(y*sca)-1, xpeak*sca:xpeak*sca+(x*sca)-1) = wallpaper(1:y*sca,1:x*sca, 1);
toc % Correlation is found, mask is placed, stop timer
% account for padding that normxcorr2 adds


% Lets have a look at the processed images
subplot(1, 2, 1);
imshow(Shanghai_proc, []);
subplot(1, 2, 2);
imshow(O_proc, []);
    
% Display end result
figure
imshow(Shanghai,[]);