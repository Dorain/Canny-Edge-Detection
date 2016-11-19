image = imread('geisel.jpeg');
k_smth = 1/159*[2 4 5 4 2;4 9 12 9 4;5 12 15 12 5;...
    4 9 12 9 4;2 4 5 4 2];
img_sm = imfilter(double(image), k_smth, 'replicate');

%% gradient computation
Sx = [-1 0 1;-2 0 2;-1 0 1];
Sy = [-1 -2 -1;0 0 0;1 2 1];
Gx = imfilter(img_sm, Sx, 'replicate', 'conv');
Gy = imfilter(img_sm, Sy, 'replicate', 'conv');
G = sqrt(Gx.^2+Gy.^2);
%% Non maximum suppression
Gtheta = atand(Gy./Gx);
round = zeros(size(Gtheta));
step = (-112.5:45:112.5);
for i = 1 : length(step)-1
    round(Gtheta>=step(i) & Gtheta<step(i+1)) =...
        (step(i)+step(i+1))/2;
end
%map degree to ve
keySet =   {-90, -45, 0, 45, 90};
valueSet = {[0 -1], [1 -1], [1 0], [1 1], [0 1]};
mapObj = containers.Map(keySet,valueSet);
nms = zeros(size(round));
%pad edge with 0
padG = padarray(G,[1,1]); 
for i = 1 : size(round,1)
    for j = 1 : size(round,2)
        tmp = mapObj(round(i,j));
        ve = padG(i+1+tmp(1), j+1+tmp(2));
        ve_r = padG(i+1-tmp(1), j+1-tmp(2));
        if(G(i,j)>=max(ve,ve_r))
            nms(i,j) = G(i,j);
        end
    end
end
img_nms = uint8(nms);
% imshow(img_nms);
%% hysteresis theshold
% t_h = 2/3*max(max(img_nms));
% t_l = 1/100*max(max(img_nms));
ht = hysthresh(img_nms, 10, 100);
% imshow(ht);
%% plotf 
f = figure;
subplot(2,2,1),imshow(uint8(img_sm));
title('Gaussian Filter with ? = 1.4');
subplot(2,2,2),imshow(uint8(G));
title('Gradient Magnitude');
subplot(2,2,3),imshow(uint8(nms));
title('Supressed Image');
subplot(2,2,4),imshow(ht);
title('Hysteresis Thresholding');
saveas(f, 'p5_figure.jpg');