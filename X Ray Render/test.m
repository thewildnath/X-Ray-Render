%close all;
clc;

cam = Camera ();
cam.resX = 150;
cam.resY = 150;
cam.focalLength = 300;
cam.stepSize = 1;

mat = zeros (100, 100, 100);
%mat = Shape.AddSphere (mat, 100, 100, 100, 100, 8.5);
%mat = Shape.AddCylinder (mat, 50, 50, 40, 40, 100, 8.5);
mat = Shape.AddCube (mat, 50, 50, 50, 50, 24.5);

tic;
img = cam.Render (mat, [1; 0; 0]);
toc;

imshow (img, [0, cam.intensity], 'Border', 'tight');