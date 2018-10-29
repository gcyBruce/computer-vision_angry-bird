function position = process_slingshot_CC(CC, region, frame)
not_detect_object = 1; %cannot detect
load('slingshot_svmModel');
CC_num = CC.NumObjects;
for i = 1: CC_num
     if region(i).Area > 800
        I2 = imcrop(frame,region(i).BoundingBox);
        scaleTestImage = imresize(I2,[256,256]);    
        featureTest = extractHOGFeatures(scaleTestImage);    
        [predictIndex,score] = predict(slingshot_classifer,featureTest);
        %figure,imshow(I2), title(char(predictIndex))
        if predictIndex == 'pos'
            %disp(region(i).Area)
            %figure,imshow(I2), title(char(predictIndex))
            rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',4,'LineStyle','-','EdgeColor','g'); 
            position = region(i).Centroid;
            not_detect_object = 0; %can detect
        end
     end
    
end
if not_detect_object    
   position = [0,0]; %assign a invalid position      
end
end