
% // find H, S, V rules
% //white bird: H > 0.035 & H < 0.2432 & S > 0.071 & S < 0.2119 & V>0.78 &
% V<0.926

function position = detect_white(frame,frame_num)
video_frame = im2double(frame);
[row,col,~] = size(video_frame);
bw = zeros(row,col);
H = video_frame(:,:,1);
S = video_frame(:,:,2);
V = video_frame(:,:,3);

% frame number that each object occurs in
have_white_bird2 = (frame_num<= 1444) && (frame_num >= 1396);
have_white_bird1 = (frame_num<= 1395) && (frame_num >= 1382);
have_white_bird3 = (frame_num<= 1387) && (frame_num >= 1385);

for x = 1:row
    for y = 1:col
       % blue bird 1
       if (have_white_bird1 || have_white_bird2 || have_white_bird3) && (H(x,y) > 0.035 && H(x,y) < 0.2432) && (S(x,y) > 0.071 && S(x,y) < 0.2119) && V(x,y)>0.78 && V(x,y)<0.926
           bw(x,y)=1;
       end   
       
    end
end
% stop button
x_button = 1:50;
y_button = 1:55;
bw(x_button, y_button) = 0;

% blue_bird grass
      x_grass = 140:row;
      y_grass = 1:col;
      bw(x_grass, y_grass) = 0;   

if have_white_bird1 
    x_others = 135:row;
    y_others = 1:140;
    bw(x_others, y_others) = 0;
    
    x_others2 = 1:row;
    y_others2 = 1:58;
    bw(x_others2, y_others2) = 0;
end

if have_white_bird3
    x_others = 106:row;
    y_others = 1:140;
    bw(x_others, y_others) = 0;
end   

% convert to connected component
bw = imfill(bw,'holes');
se =strel('disk',4,4);
bw2 = imclose(bw,se);
%bw2 = imdilate(bw2,se);
bw2 = imdilate(bw2,se);
CC=bwconncomp(bw2);
CC_num = CC.NumObjects;
  %figure, imshow(bw);
  %figure, imshow(bw2);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 

if CC_num > 0
[label,~] = bwlabel(bw2);
region = regionprops(label,bw2,{'Area', 'Centroid', 'BoundingBox', 'PixelValues'});
position = process_whitebird_CC(CC, region, frame, frame_num); 
else
    position = [0,0];
end
end 


