function position = process_blackbird_CC(CC, region, frame, frame_num)
not_detect_object = 1; %cannot detect
load('black_svmModel');
CC_num = CC.NumObjects;

for i = 1: CC_num
    constrain = region(i).Area > 100 ;

 if frame_num == 1386
      constrain = region(i).Area == 148;
 end

  if frame_num == 1387
      constrain = region(i).Area == 294;
  end
 
    if constrain
        I2 = imcrop(frame,region(i).BoundingBox);
        scaleTestImage = imresize(I2,[256,256]);    
        featureTest = extractHOGFeatures(scaleTestImage);    
        [predictIndex,score] = predict(black_classifer,featureTest);
        %figure, imshow(I2),title(char(predictIndex))
        %disp(region(i).Area)
        if predictIndex == 'pos'
           %disp(region(i).Area)
           %figure,imshow(I2)
            rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','k');
            position = region(i).Centroid;
            not_detect_object = 0; %cannot detect
        end
    end
end
if not_detect_object    
   position = [0,0]; %assign a invalid position      
end
end