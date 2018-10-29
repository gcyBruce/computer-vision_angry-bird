
% // find H, S, V rules
% //blue bird: H > 0.18 & H < 0.50 & S > 0.26 & S < 0.79 & V>0.36 &
% V<0.82

function position = detect_blue( frame,frame_num)
video_frame = im2double(frame);
[row,col,~] = size(video_frame);
bw = zeros(row,col);
H = video_frame(:,:,1);
S = video_frame(:,:,2);
V = video_frame(:,:,3);

% frame number that each object occurs in
have_blue_bird1 = (frame_num< 780) && (frame_num >= 714);
have_blue_bird2 = (frame_num<= 784) && (frame_num >= 780);

for x = 1:row
    for y = 1:col
       % blue bird 1
       if (have_blue_bird2 || have_blue_bird1) && (H(x,y) > 0.18 && H(x,y) < 0.50) && (S(x,y) > 0.05 && S(x,y) < 0.79) && V(x,y)>0.36 && V(x,y)<0.82
           bw(x,y)=1;
       end   
       
    end
end

% stop button
x_button = 1:70;
y_button = 1:55;
bw(x_button, y_button) = 0;

% score
 x_score = 1:56;
 y_score = 328:480;
 bw(x_score, y_score) = 0;

% blue_bird grass
if have_blue_bird2
      x_grass = 200:row;
      y_grass = 1:col;
      bw(x_grass, y_grass) = 0;   
end

if have_blue_bird1
      x_grass = 200:row;
      y_grass = 1:col;
      bw(x_grass, y_grass) = 0;   
end

% convert to connected component
bw = imfill(bw,'holes');
se =strel('disk',4,4);
se2 = [0 1 0; 1 1 1; 0 1 0];
bw2 = imclose(bw,se);
bw2 = imerode(bw2,se2);
bw2 = imdilate(bw2,se);
CC=bwconncomp(bw2);
CC_num = CC.NumObjects;
  %figure, imshow(bw);
  %figure, imshow(bw2);

if CC_num > 0
[label,~] = bwlabel(bw2);
region = regionprops(label,bw2,{'Area', 'Centroid', 'BoundingBox', 'PixelValues'});
position = process_bluebird_CC(CC, region, frame, frame_num); 
else
    position(1,:) = [0,0];
end
end 

