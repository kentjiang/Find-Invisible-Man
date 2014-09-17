function [result,x, y, h, w]=tmp(image1,image2,left,right);
h = waitbar(0,'finding');
%
% By Alaa Eleyan Nov,2005
%*********************************************************

    image1=rgb2gray(image1);
    image2=rgb2gray(image2);
    % er yi mei you
    image2 = image2 - medfilt2(image2, [3 2]);
    %image2 = image2 - medfilt2(image2, [2 1]); %LIU
    %image2 = image2 - medfilt2(image2, [3 2]); %LIU
    %image2 = image2 - medfilt2(image2, [2 1]); %SHIER
    %image2 = image2 - medfilt2(image2, [1 2]); %SHIER
    %image2 = image2 - medfilt2(image2, [3 2]); %SHIQI
    %image2 = image2 - medfilt2(image2, [3 1]); %SHIQI
    image2=edge(double(image2),'canny');
    image2 = uint8(image2*255);

% check which one is target and which one is template using their size

if size(image1)>size(image2)
    Target=image1;
    Template=image2;
else
    Target=image2;
    Template=image1;
end

% find both images sizes
[r1,c1]=size(Target);
[r2,c2]=size(Template);
% mean of the template
image22=Template-mean(mean(Template));

%corrolate both images
M=[];
for i=1:(r1-r2+1)
     waitbar(i/1000,h);
    for j=left:(right-c2+1)
        Nimage=Target(i:i+r2-1,j:j+c2-1);
        Nimage=Nimage-mean(mean(Nimage));  % mean of image part under mask
        corr=sum(sum(Nimage.*image22));
        warning off
        M(i,j)=corr/sqrt(sum(sum(Nimage.^2)));
    end 
end
close(h);
% plot box on the target image
[result,x, y, h, w]=plotbox(Target,Template,M);
