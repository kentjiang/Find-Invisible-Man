function [line1_x, line2_x, line3_x, line4_x,line1_y,line2_y,line3_y,line4_y, im2] = main(path)


% read Template image
im1=imread('liu_temp.JPG');
%im1=imread('S.bmp');
%im1=imread('image1.jpg');


% read Traget Image
im2=imread(path);
%im2=imread('image2.jpg');


%hough find boundary
BW = im2;
BW=rgb2gray(BW);
%BW = BW - medfilt2(BW, [3 2]);  
thresh=[0.01,0.17];  
sigma=2; 
f = edge(double(BW),'canny');  
[H, theta, rho]= hough(f, 'Theta', -0.0001:0.0001);  
%imshow(theta,rho,H,[],'notruesize'),axis on,axis normal  
%xlabel('\theta'),ylabel('rho');  
  
peak=houghpeaks(H,5);  
hold on  
  
lines=houghlines(f,theta,rho,peak);  
figure,imshow(f,[]),title('Hough Transform Detect Result'),hold on 
left = length(BW);
right = 0;
for k=1:length(lines)  
    xy=[lines(k).point1;lines(k).point2]; 
    left = min(xy(1,1),left);
    right = max(right,xy(1,1));
    plot(xy(:,1),xy(:,2),'r','LineWidth',3); 
end  
left = max(1,left - 20);
right = min(size(im2,2), right + 20);



% apply templete matching using power of the image
[result1,y, x, h, w]=tmp(im1,im2,left,right);
% 
% figure(1)
% subplot(2,2,1),imshow(im1);title('Template');
% subplot(2,2,2),imshow(im2);title('Target');
% subplot(2,2,3),imshow(result1);title('Matching Result using tmp');

line1_x = zeros(1,w);
line1_y = zeros(1,w);
line2_x = zeros(1,w);
line2_y = zeros(1,w);
line3_x = zeros(1,h);
line3_y = zeros(1,h);
line4_x = zeros(1,h);
line4_y = zeros(1,h);


for i = 1 : w
   line1_x(1,i) = i + x - 1;
   line1_y(1,i) = y;
   line2_x(1,i) = i + x - 1;
   line2_y(1,i) = y + h;
end

for i = 1 : h
   line3_x(1,i) = x;
   line3_y(1,i) = i + y - 1;
   line4_x(1,i) = x + w;
   line4_y(1,i) = i + y - 1;
end

% figure(3);
% imshow(result1);
% hold on;
% plot(line1_x,line1_y,'r','linewidth',2);
% hold on;
% plot(line2_x,line2_y,'r','linewidth',2);
% hold on;
% plot(line3_x,line3_y,'r','linewidth',2);
% hold on;
% plot(line4_x,line4_y,'r','linewidth',2);
% 
% figure(4);
% imshow(im2);
% hold on;
% plot(line1_x,line1_y,'r','linewidth',2);
% hold on;
% plot(line2_x,line2_y,'r','linewidth',2);
% hold on;
% plot(line3_x,line3_y,'r','linewidth',2);
% hold on;
% plot(line4_x,line4_y,'r','linewidth',2);

