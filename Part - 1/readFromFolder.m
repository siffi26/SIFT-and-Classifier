function [trainingImage, group] = readFromFolder(path)
clc;    
workspace;  
format long g;
format compact;
path
start_path = fullfile(path);
topLevelFolder = start_path;
if topLevelFolder == 0
	return;
end
allSubFolders = genpath(topLevelFolder);
remain = allSubFolders;
listOfFolderNames = {};
while true
	[singleSubFolder, remain] = strtok(remain, ';');
	if isempty(singleSubFolder)
		break;
	end
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames);
% trainingImage = zeros(1500, 256);
% group = zeros(1500, 1);
count = 0;
for k = 1 : numberOfFolders
	thisFolder = listOfFolderNames{k};	
	filePattern = sprintf('%s/*.jpg', thisFolder);
	baseFileNames = dir(filePattern);
	numberOfImageFiles = length(baseFileNames);	
	if numberOfImageFiles >= 1
		for f = 1 : numberOfImageFiles
			fullFileName = fullfile(thisFolder, baseFileNames(f).name);
            I = imread(fullFileName);
            New_I = imresize(I, [16,16]);
            New_I = reshape(New_I, [1,256]);
%             New_I = imresize(New_I, [1,256], 'bilinear');
            New_I = double(New_I);
            count=count+1;
            trainingImage(count,:) = New_I; 
            group(count, :) = k-1;
% 			fprintf('Processing image file %s\n', fullFileName);
        end
	end
end
count




