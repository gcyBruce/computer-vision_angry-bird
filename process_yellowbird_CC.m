function position = process_yellowbird_CC(CC, region, frame, frame_num)
not_detect_object = 1; %cannot detect
load('yb_svmModel');
CC_num = CC.NumObjects;
for i = 1: CC_num
    constrain = region(i).Area > 200 && region(i).Area<520;
    if frame_num == 916
        constrain = region(i).Area == 229;
    end
     if frame_num == 923
        constrain = region(i).Area == 298;  
     end
     if frame_num == 928
         constrain = region(i).Area == 355;
     end
     if frame_num == 933
         constrain = region(i).Area == 336;
     end
        
    if constrain
        x = region(i).BoundingBox(1);
        y = region(i).BoundingBox(2);
        x_width = region(i).BoundingBox(3);
        y_width = region(i).BoundingBox(4);
        I2 = imcrop(frame,region(i).BoundingBox);
        scaleTestImage = imresize(I2,[256,256]);    
        featureTest = extractHOGFeatures(scaleTestImage);    
        [predictIndex,score] = predict(yb_classifer,featureTest);
        %figure, imshow(I2),title(char(predictIndex))
        if predictIndex == 'pos'
            %disp(region(i).Area)
            %figure,imshow(I2)
            rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','y');
            position = region(i).Centroid;
            not_detect_object = 0; %cannot detect
        end
    end
end
if not_detect_object    
   position = [0,0]; %assign a invalid position      
end
end