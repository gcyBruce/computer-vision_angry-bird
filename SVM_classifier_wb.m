% training set
imdsTrain = imageDatastore('./SVM/white_bird/training',...    
    'IncludeSubfolders',true,...    
    'LabelSource','foldernames');
imdsTest = imageDatastore('./SVM/white_bird/test');   
% Train_disp = countEachLabel(imdsTrain);  
% disp(Train_disp);

% preprocess
imageSize = [256,256];  
image1 = readimage(imdsTrain,1);    
scaleImage = imresize(image1,imageSize);    
[features, visualization] = extractHOGFeatures(scaleImage);    
%imshow(scaleImage);hold on; plot(visualization) 

% extract HOG features of the whole training data   
numImages = length(imdsTrain.Files);    
featuresTrain = zeros(numImages,size(features,2),'single'); % featuresTrain is single   
for i = 1:numImages    
    imageTrain = readimage(imdsTrain,i);    
    imageTrain = imresize(imageTrain,imageSize);    
    featuresTrain(i,:) = extractHOGFeatures(imageTrain);    
end  

% all training data labels    
trainLabels = imdsTrain.Labels;    
    
% fitcsvm for binary classification?fitcecoc for multi
wb_classifer = fitcsvm(featuresTrain,trainLabels);   

    
% predict  
% numTest = length(imdsTest.Files);    
% for i = 1:numTest    
%     testImage = readimage(imdsTest,i);    
%     scaleTestImage = imresize(testImage,imageSize);    
%     featureTest = extractHOGFeatures(scaleTestImage);    
%     [predictIndex,score] = predict(yb_classifer,featureTest);    
%     figure;imshow(testImage);    
%     title(['predictImage: ',char(predictIndex)]);    
% end    
save('wb_svmModel','wb_classifer');