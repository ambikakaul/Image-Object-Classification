% run vl_setup, check vlfeat version and load pkg image
cd vlfeat-0.9.16/toolbox
vl_setup 
disp("vl_version") ;
exist('vl_version') 
pkg load image
cd ../..
