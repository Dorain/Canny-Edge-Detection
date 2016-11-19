# Canny-Edge-Detection

Smoothing: First, we need to smooth the images to remove noise from being considered as edges. Here we use gaussian smoothing.

Gradient Computation: After you have finished smoothing, find the image gradient in the horizontal and vertical directions. You can use Sobel operators 2 as your filter kernel to calculate Gx and Gy. Gx and Gy are the gradients along the x and y axis respectively. sx and sy are the corresponding kernels. Compute the gradient magnitude image as |G| =
 G2 + G2 . The edge direction as each pixel is given as G = tan−1 ( Gy ).
 
Non Maximum suppression: Our desired edges need to be sharp, not thick like the ones in gradient image. Here we use non maximum suppression to preserve all local maximas and discard the rest.The method are as followed:
– For each pixel do:
∗ Round the gradient direction θ to the nearest multiple of 45◦ in a 8-connected neigh- bourhood.
∗ Compare the edge strength at the current pixel to the pixels along the +ve and −ve gradient direction in the 8-connected neighbourhood.
∗ Preserve the values of only those pixels which have maximum gradient magnitudes in the neighbourhood along the +ve and −ve gradient direction.

• Hysteresis Thresholding: Choose optimum values of thresholds and use the thresholding approach. This will remove the edges caused due to noise and colour variations.
