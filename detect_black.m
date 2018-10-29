%have_black_bird = (frame_num<= 1177) && (frame_num >= 1106)
function position = detect_black(frame, frame_num)
video_frame = im2double(frame);
[row,col,~] = size(video_frame);
bw = zeros(row,col);
H = video_frame(:,:,1);
S = video_frame(:,:,2);
V = video_frame(:,:,3);
for x = 1:row
    for y = 1:col
        if H(x,y)>0.15 && H(x,y)<0.3 && S(x,y)>0.6 && V(x,y)>0.1 && V(x,y)<0.5
           bw(x,y)= 1;
       end  
    end
end

% RGB_path = ['./RGB_frames/',num2str(frame_num),'.jpg'];
% figure,imshow(RGB_path)

% remove grass
x_grass = 193:row;
y_grass = 1:col;
bw(x_grass, y_grass) = 0;

if (frame_num == 1126)
    x_slingshot = 148:194;
    y_slingshot = 99:123;
    bw(x_slingshot, y_slingshot) = 0;
end

if (frame_num <= 1138 && frame_num >= 1132)
    x_slingshot = 1:row;
    y_slingshot = 1:65;
    bw(x_slingshot, y_slingshot) = 0;
end

if (frame_num <= 1131 && frame_num >= 1130)
    x_slingshot = 1:row;
    y_slingshot = 1:78;
    bw(x_slingshot, y_slingshot) = 0;
end

% process connected component (CC)
bw = imfill(bw,'holes');
se =strel('rectangle',[10 5]);
bw2 = imdilate(bw,se);
CC = bwconncomp(bw2);
CC_num = CC.NumObjects;
%imshow(bw)

if CC_num > 0
[label,~] = bwlabel(bw2);
region = regionprops(label,bw2,{'Area', 'Centroid', 'BoundingBox', 'PixelValues'});
position = process_blackbird_CC(CC, region, frame, frame_num); 
else
    position = [0,0];
end
end