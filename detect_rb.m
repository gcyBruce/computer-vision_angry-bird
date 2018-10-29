function position = detect_rb(frame, frame_num)
video_frame = im2double(frame);
[row,col,~] = size(video_frame);
bw = zeros(row,col);
H = video_frame(:,:,1);
S = video_frame(:,:,2);
V = video_frame(:,:,3);
for x = 1:row
    for y = 1:col
        if H(x,y)>0.8 && S(x,y)>0.7 && V(x,y)>0.4 && V(x,y)<0.9
           bw(x,y)= 2;
       end  
    end
end

% RGB_path = ['./RGB_frames/',num2str(frame_num),'.jpg'];
% figure,imshow(RGB_path)

% remove stop button
x_button = 1:50;
y_button = 1:55;
bw(x_button, y_button) = 0;

if (frame_num <= 500 && frame_num >= 381)
    x_grass = 210:row;
    y_grass = 1:col;
    bw(x_grass, y_grass) = 0;
end
if(frame_num >=1680 && frame_num <=1715)
    x_grass = 250:row;
    y_grass = 1:col;
    bw(x_grass, y_grass) = 0;
end
% process connected component (CC)
bw = imfill(bw,'holes');
se =strel('rectangle',[11 5]);
bw2 = imdilate(bw,se);
CC = bwconncomp(bw2);
CC_num = CC.NumObjects;
if CC_num > 0
[label,~] = bwlabel(bw2);
region = regionprops(label,bw2,{'Area', 'Centroid', 'BoundingBox', 'PixelValues'});
position = process_redbird_CC(CC, region, frame, frame_num);
else
    position = [0,0];
end
end