close all;
clear;
im= imread('lena.png');
%im = rgb2gray(im);
myedge = edge(im, 'canny');
bw= double(im) ./ 256;

lamda = 0.5;
bw1 = bw - mean(bw(:));
%bw1 = bw;
bw2 = bw*0.5 + myedge*0.5;
bw2 = bw2 - mean(bw2(:));

 figure;
 subplot(1,4,1),subimage(bw);
 subplot(1,4,2),subimage(bw1);
 subplot(1,4,3),subimage(myedge);
 subplot(1,4,4),subimage(bw2);


% generate convolution kernal
% kernal1: patch extracted from original image without flip
% kernal2: patch extracted from original image with flip
% kernal3: patch extracted from (original+edge) image with flip
x = 400; y=150; w = 64; h=64;  % kernal position and size
%x = 245; y=245; w = 36; h=36;  % kernal position and size
%x = 360; y=260; w = 36; h=36;  % kernal position and size
PY0 = [x,x+w,x+w,x,x];
PX0 = [y,y,y+h,y+h,y];
kernal1 = bw1(x:x+w,y:y+h);
kernal2 = rot90(bw1(x:x+w,y:y+h),2);
kernal3 = rot90(bw2(x:x+w,y:y+h),2); % same operation: flipud(fliplr(bw2(x:x+w,y:y+h)));
figure;
subplot(1,3,1),subimage((kernal1-min(kernal1(:)))/(max(kernal1(:))-min(kernal1(:))));
subplot(1,3,2),subimage((kernal2-min(kernal2(:)))/(max(kernal2(:))-min(kernal2(:))));
subplot(1,3,3),subimage((kernal3-min(kernal3(:)))/(max(kernal3(:))-min(kernal3(:))));

% convolute with three kernals
convimg= myconv2(bw1, kernal1, 'same');
%convimg2 = myconv2(bw1, kernal1, 'same');
% if isequal(convimg, convimg2)
%     'ok'
% end
convimg= (convimg-min(convimg(:)))/(max(convimg(:))-min(convimg(:)));
%figure;subplot(1,3,1),subimage(convimg);
[~, idx] = max(convimg(:));
cx1 = mod(idx,size(convimg,2)); cy1 = floor(idx/size(convimg,1));
PY1 = [cx1-w/2,cx1+w/2,cx1+w/2,cx1-w/2,cx1-w/2];
PX1 = [cy1-h/2,cy1-h/2,cy1+h/2,cy1+h/2,cy1-h/2];
Z1 = bw1 + convimg*lamda;
Z1 = (Z1 - min(Z1(:)))/(max(Z1(:))-min(Z1(:)));
C1 = convimg;


convimg= myconv2(bw1, kernal2, 'same');
convimg= (convimg-min(convimg(:)))/(max(convimg(:))-min(convimg(:)));
%subplot(1,3,2),subimage(convimg);
[~, idx] = max(convimg(:));
cx2 = mod(idx,size(convimg,2)); cy2 = floor(idx/size(convimg,1));
PY2 = [cx2-w/2,cx2+w/2,cx2+w/2,cx2-w/2,cx2-w/2];
PX2 = [cy2-h/2,cy2-h/2,cy2+h/2,cy2+h/2,cy2-h/2];
Z2 = bw1 + convimg*lamda;
Z2 = (Z2 - min(Z2(:)))/(max(Z2(:))-min(Z2(:)));
C2 = convimg;

convimg= myconv2(bw2, kernal3, 'same');
convimg= (convimg-min(convimg(:)))/(max(convimg(:))-min(convimg(:)));
%subplot(1,3,3),subimage(convimg);
[c, idx] = max(convimg(:));
cx3 = mod(idx,size(convimg,2)); cy3 = floor(idx/size(convimg,1));
PY3 = [cx3-w/2,cx3+w/2,cx3+w/2,cx3-w/2,cx3-w/2];
PX3 = [cy3-h/2,cy3-h/2,cy3+h/2,cy3+h/2,cy3-h/2];
Z3 = bw2 + convimg*lamda;
Z3 = (Z3 - min(Z3(:)))/(max(Z3(:))-min(Z3(:)));
C3 = convimg;

figure;
subplot(2,3,1),subimage(Z1),hold on,plot(PX0,PY0,'b','LineWidth',1),plot(PX1,PY1,'r','LineWidth',1);
subplot(2,3,2),subimage(Z2),hold on,plot(PX0,PY0,'b','LineWidth',1),plot(PX2,PY2,'r','LineWidth',1);
subplot(2,3,3),subimage(Z3),hold on,plot(PX0,PY0,'b','LineWidth',1),plot(PX3,PY3,'r','LineWidth',1);
subplot(2,3,4),subimage(C1),hold on,plot(PX1,PY1,'r','LineWidth',1);
subplot(2,3,5),subimage(C2),hold on,plot(PX2,PY2,'r','LineWidth',1);
subplot(2,3,6),subimage(C3),hold on,plot(PX3,PY3,'r','LineWidth',1);
