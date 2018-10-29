function position = detect_slingshot(frame, frame_num)
video_frame = im2double(frame);
[row,col,~] = size(video_frame);
bw = zeros(row,col);
H = video_frame(:,:,1);
S = video_frame(:,:,2);
V = video_frame(:,:,3);
for x = 1:row
    for y = 1:col
        if (H(x,y)>0.05 && H(x,y)<0.13) && (S(x,y)<1 && S(x,y)>0.4) && (V(x,y)>0.4 && V(x,y)<0.8)
           bw(x,y)= 6;
       end  
    end
end

% RGB_path = ['./RGB_frames/',num2str(frame_num),'.jpg'];
% figure,imshow(RGB_path)

% remove stop button
x_button = 1:50;
y_button = 1:55;
bw(x_button, y_button) = 0;

bw = imfill(bw,'holes');
se =strel('rectangle',[10 5]);
bw2 = imdilate(bw,se);
CC = bwconncomp(bw2);
[label,~] = bwlabel(bw2);
region = regionprops(label,bw2,{'Area', 'Centroid', 'BoundingBox', 'PixelValues'});
n = CC.NumObjects;
    for j = 1: n
        if region(j).Area > 800
           if n == 1
                rectangle('Position',region(j).BoundingBox,'Curvature',[0,0],'LineWidth',4,'LineStyle','-','EdgeColor','m');
                position = region(j).Centroid;
           else
                position = process_slingshot_CC(CC, region, frame);
           end
        end
    end
end 