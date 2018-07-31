clear
clc
load bag_of_word_400.mat
numClusters=1000;
% train_labels=ones(1500,1)*-1;
% train_labels(1:100)=1;
% test_labels=ones(150,1)*-1;
% test_labels(1:10)=1;
train_labels=zeros(1500,1);
% categories = {'Kitchen', 'Store', 'Bedroom', 'LivingRoom', 'Office', ...
%        'Industrial', 'Suburb', 'InsideCity', 'TallBuilding', 'Street', ...
%        'Highway', 'OpenCountry', 'Coast', 'Mountain', 'Forest'};
categories={'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15'};
% for i=1:15
%     train_labels((i-1)*100+1:i*100)=i;
% end
% categories = unique(train_labels); 
num_categories = length(categories);

% lambda = 1e-05;45
lambda = 4e-05;
% lambda = 1e-6;

test_labels=zeros(150,1);
for i=1:15
    test_labels((i-1)*10+1:i*10)=i;
end
acc_table=zeros(100,1);
for it=1:100
    scores = [];
    for i = 1:num_categories
        % Create a training label
        train_labels=ones(1500,1)*-1;
        train_labels((i-1)*100+1:i*100,1)=1;
        % Train a linvear SVM classifier
        [w, b] = vl_svmtrain(train_image_feats', train_labels, lambda);

        scores = [scores; (w' * test_image_feats' + b) ];
    %     scores = [scores; (w' * train_image_feats' + b) ];
    end

    % get maximum scores
    [max_values, max_indices] = max(scores);
    predicted_categories = categories(max_indices');
    acc=0;
    for i=1:150
        if test_labels(i)==str2double(predicted_categories{i})
            acc=acc+1;
        end
    end
    acc_table(it)=acc;
end
% acc=0;
% train_labels=zeros(1500,1);
% for i=1:15
%     train_labels((i-1)*100+1:i*100)=i;
% end
% for i=1:1500
%     if train_labels(i)==str2double(predicted_categories{i})
%         acc=acc+1;
%     end
% end