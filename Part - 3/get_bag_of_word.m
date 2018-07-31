clc 
clear 
close all

load vocabulary_400.mat
skip = 3;
path={'train\','test\'};
imag_size=[100 10];
forest = vl_kdtreebuild(vocab');
for step=1:2
    image_path = path{step};
    subset_prefix = dir(image_path); 
    subset_prefix=subset_prefix(skip+1:end);
    subset_num=size(subset_prefix,1);
    labels=zeros(15,imag_size(step));
    vocab_size=1000;
    image_feats=zeros(15*imag_size(step),1000);
    
    for i = 1:subset_num
%     for i = 1
        subset=strcat(image_path,subset_prefix(i).name,'\');
        images=dir(subset);
        images=images(3:end);
        image_num=size(images,1);
        labels(i,:)=i;
        for j = 1:image_num
%         for j = 1
            imgname =strcat(subset,images(j).name);
            img=imread(imgname);
            imshow(img);
            img=single(img);
            step_size = 2;
%             step_size = 8;
            bin_size = 8;
            [locations, SIFT_features] = vl_dsift(img, 'step', step_size, 'size', bin_size);
%             [locations, SIFT_features] = vl_sift(img,'EdgeThresh',3);
%             h1 = vl_plotframe(locations) ;
%             h2 = vl_plotframe(locations) ;
%             set(h1,'color','k','linewidth',3) ;
%             set(h2,'color','y','linewidth',2) ;
            [index , dist] = vl_kdtreequery(forest , vocab' , double(SIFT_features));
            feature_hist = hist(double(index), vocab_size);
            feature_hist = feature_hist ./ sum(feature_hist);
            image_feats((i-1)*imag_size(step)+j, :) = feature_hist;
        end
    end
    if step==1
        train_image_feats=image_feats;
    else
        test_image_feats=image_feats;
    end
end
save bag_of_word_400 train_image_feats test_image_feats