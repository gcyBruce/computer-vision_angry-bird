function position = process_redbird_CC(CC, region, frame, frame_num)
not_detect_object = 1; %cannot detect red bird
if (frame_num <= 500 && frame_num >= 381)
    load('rb_svmModel_1');
    CC_num = CC.NumObjects;
for i = 1: CC_num
    if (region(i).Area < 600) 
        I2 = imcrop(frame,region(i).BoundingBox);
        scaleTestImage = imresize(I2,[256,256]);    
        featureTest = extractHOGFeatures(scaleTestImage);    
        [predictIndex,score] = predict(rb_classifer,featureTest);
        %figure,imshow(I2), title(char(predictIndex))
        if predictIndex == 'pos'
            %disp(region(i).Area)
            %figure,imshow(I2), title(char(predictIndex))
            rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','r'); 
            position = region(i).Centroid;
            not_detect_object = 0; %can detect red bird
        end
        
    end
end
end
if(frame_num >=1680 && frame_num <=1715)
    load('rb_svmModel_2');
    CC_num = CC.NumObjects;
for i = 1: CC_num
    if (region(i).Area < 600) 
        I2 = imcrop(frame,region(i).BoundingBox);
        scaleTestImage = imresize(I2,[256,256]);    
        featureTest = extractHOGFeatures(scaleTestImage);    
        [predictIndex,score] = predict(rb_classifer_2,featureTest);
        %figure,imshow(I2), title(char(predictIndex))
        if predictIndex == 'pos'
            %disp(region(i).Area)
            %figure,imshow(I2), title(char(predictIndex))
            rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','r'); 
            position = region(i).Centroid;
            not_detect_object = 0; %can detect red bird
        end
    end
end
end
if not_detect_object    
   position = [0,0]; %assign a invalid position      
end
end