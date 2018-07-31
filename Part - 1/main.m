clc;    
workspace; 
trainPath = 'C:\Users\Siffi Singh\Desktop\cv4\hw4_data\train';
[trainingImages, group] = readFromFolder(trainPath);
testPath = 'C:\Users\Siffi Singh\Desktop\cv4\hw4_data\test';
[testImages, group1] = readFromFolder(testPath);
for i = 1:100
    Md1 = fitcknn(double(trainingImages), group, 'NumNeighbors', i);
    Class = predict(Md1, double(testImages));
    E = sum(Class == group1);
    e(i, :) = E;
    ii(i, :) = i;
    xx(i, :) = (E/150)*100;
end
figure(1);
plot(ii, e);
[maxy, maxyidx] = max(e);
maxx = ii(maxyidx);
maxx
Md1 = fitcknn(double(trainingImages), group,'NumNeighbors', maxx);
Class = predict(Md1, double(testImages));
[E, n] = meanabs(Class - group1);
figure(2);
plot(ii, xx);
X = (sum(Class == group1)/150)*100;
X