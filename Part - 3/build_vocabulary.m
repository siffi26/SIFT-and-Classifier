clc 
clear 
close all

skip = 3;
image_train = 'train\';
subset_prefix = dir(image_train); 
subset_prefix=subset_prefix(skip+1:end);
subset_num=size(subset_prefix,1);
features=[];
labels=zeros(15,100);
descriptor_num=zeros(subset_num,1);
descriptor_in_image=zeros(15,100);
% vocab_size=1000;
vocab_size=400;
for i = 1:subset_num
    subset=strcat(image_train,subset_prefix(i).name,'\');
    images=dir(subset);
    images=images(3:end);
    image_num=size(images,1);
    labels(i,:)=i;
    for j = 1:image_num
        imgname =strcat(subset,images(j).name);
        img=imread(imgname);
        imshow(img);
        img=single(img);
        step = 15;
        bin_size = 8;
        [locations, SIFT_features] = vl_dsift(img, 'fast', 'step', step, 'size', bin_size);
%          [locations, SIFT_features] = vl_sift(img,'EdgeThresh',3);
        features=[features,SIFT_features];
        [~,n]=size(SIFT_features);
        descriptor_in_image(i,j)=n;
        descriptor_num(i)=descriptor_num(i)+n;
       
%         descriptor_vector(i,j,:)=d;
    end
end
[centers, assignments] = vl_kmeans(double(features), vocab_size);
vocab = centers';
save vocabulary_400 vocab descriptor_in_image descriptor_num