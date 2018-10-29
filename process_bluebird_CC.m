function position = process_bluebird_CC(CC, region, frame, frame_num)
not_detect_object = 1; %cannot detect
load('bb_svmModel');
CC_num = CC.NumObjects;
position = zeros(3,2);
for i = 1: CC_num
    constrain = region(i).Area > 55 && region(i).Area < 500;

 
    if frame_num == 726
           constrain = region(i).Area == 158;
    end


    if constrain
        I2 = imcrop(frame,region(i).BoundingBox);
        scaleTestImage = imresize(I2,[256,256]);    
        featureTest = extractHOGFeatures(scaleTestImage);    
        [predictIndex,score] = predict(bb_classifer,featureTest);
        %figure, imshow(I2),title(char(predictIndex));
        %disp(region(i).Area);
        if predictIndex == 'pos'
           disp(region(i).Area)
           %figure,imshow(I2)
            rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','b');
            if frame_num < 763
            position(1,:) = region(i).Centroid;
            end
            
            if frame_num >= 763
                if position(1,1) == 0
                    position(1,:) = region(i).Centroid;
                elseif position(2,1) == 0
                    position(2,:) = region(i).Centroid;
                     else
                        position(3,:) = region(i).Centroid;
                        
              
                end
            end    
            not_detect_object = 0; %cannot detect
        end
    end
end
if not_detect_object    
   position(1,:) = [0,0]; %assign a invalid position      
end
end