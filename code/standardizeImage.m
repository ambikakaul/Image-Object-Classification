function im = standardizeImage(im)
% STANDARDIZEIMAGE  Rescale an image to a standard size
%   IM = STANDARDIZEIMAGE(IM) rescale IM to have a height of at most
%   480 pixels.


%im = im2single(im) ;
%size(im)
if size(im,1) > 480,  im = imresize(im, [480 NaN]) ; end
%size(im)
if ndims(im) == 3,  im = rgb2gray(im); ; end
%im = rgb2gray(im);
%size(im)
im = im2single(im) ;

%size(im)
