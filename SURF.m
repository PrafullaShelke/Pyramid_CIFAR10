% read a file from CIFAR 10 dataset
img=imread('E:\IIT KGP\ML Project\datasets\CIFAR10_matlab\batch1\47.jpg');

% convert the file to gray scale 
img=rgb2gray(img);

% resize the image to get the big picture 
img = imresize(img,[128 128])

% detect the surf features from the image 
points = detectSURFFeatures(img)

% display the detected top 20 features using plot
imshow(img); hold on;
plot(points.selectStrongest(20));

% capture the feature into a vector which can be stored later
[f1,v1] = extractFeatures(img,points)

% we can then save the feature vector for each image and then use them in
% later stage for classification or clustering tasks

save('SURFFeatures.mat','f1')
