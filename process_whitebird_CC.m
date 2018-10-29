function position = process_whitebird_CC(CC, region, frame, frame_num)
not_detect_object = 1; %cannot detect
load('wb_svmModel');
CC_num = CC.NumObjects;

for i = 1: CC_num
    constrain = region(i).Area > 70 ;

 if frame_num == 1386
      constrain = region(i).Area == 148;
 end

  if frame_num == 1387
      constrain = region(i).Area == 294;
  end
 
if (region(i).Area > 100 ) && (frame_num == 1382 || 1388 || 1389 )
     rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','w');
            position = region(i).Centroid;
            not_detect_object = 0; %cannot detect
end

if (region(i).Area > 59 ) && (frame_num == 1432 || 1431 )
     rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','w');
            position = region(i).Centroid;
            not_detect_object = 0; %cannot detect
end
    if constrain
        I2 = imcrop(frame,region(i).BoundingBox);
        scaleTestImage = imresize(I2,[256,256]);    
        featureTest = extractHOGFeatures(scaleTestImage);    
        [predictIndex,score] = predict(wb_classifer,featureTest);
        %figure, imshow(I2),title(char(predictIndex))
         %disp(region(i).Area)
        if predictIndex == 'pos'
            %disp(region(i).Area)
           %figure,imshow(I2)
            rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','w');
            position = region(i).Centroid;
            not_detect_object = 0; %cannot detect
        end
    end
end
if not_detect_object    
   position = [0,0]; %assign a invalid position      
end
end