clear all;                                         
batch1=load('data_batch_1.mat');
batch2=load('data_batch_2.mat');
batch3=load('data_batch_4.mat');
batch4=load('data_batch_4.mat');
batch5=load('data_batch_5.mat');
test_batch=load('test_batch.mat');
traindata=cell(10,1);
[ traindata ] = makedata( batch1 ,traindata);
[ traindata ] = makedata( batch2 ,traindata);
[ traindata ] = makedata( batch3 ,traindata);
[ traindata ] = makedata( batch4 ,traindata);
[ traindata ] = makedata( batch5 ,traindata);
testdata=cell(10,1);
[testdata]=makedata(test_batch,testdata);
k=500;
dataset=cell(10,1);
for i=1:10
    tmp=[];
    tmp=[double(traindata{i});double(testdata{i})];
    [coeff,score,l]=pca(tmp);
    score=score(:,[1:k]);
    datset{i}=score;
end
[traindata,testdata,sizevect] = datasetforgmm(datset');
a=1;
for i=1:10
    n=sizevect(i);
    for k=1:n
        orig(a)=i;
        a=a+1;
    end
end

m = 40;
reg = 0.05;
eff=[];
m1 = gmdistribution.fit(traindata{1},m,'Regularize',reg);
m2 = gmdistribution.fit(traindata{2},m,'Regularize',reg);
m3 = gmdistribution.fit(traindata{3},m,'Regularize',reg);
m4 = gmdistribution.fit(traindata{4},m,'Regularize',reg);
m5 = gmdistribution.fit(traindata{5},m,'Regularize',reg);
m6 = gmdistribution.fit(traindata{6},m,'Regularize',reg);
m7 = gmdistribution.fit(traindata{7},m,'Regularize',reg);
m8 = gmdistribution.fit(traindata{8},m,'Regularize',reg);
m9 = gmdistribution.fit(traindata{9},m,'Regularize',reg);
m10 = gmdistribution.fit(traindata{10},m,'Regularize',reg);

p1=pdf(m1,testdata);
p2=pdf(m2,testdata);
p3=pdf(m3,testdata);
p4=pdf(m4,testdata);
p5=pdf(m5,testdata);
p6=pdf(m6,testdata);
p7=pdf(m7,testdata);
p8=pdf(m8,testdata);
p9=pdf(m9,testdata);
p10=pdf(m10,testdata);

fProb = [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10];
[final,index]=max(fProb');

chec=[orig;index];
conf=confusionmat(orig,index);
t=size(testdata,1);
eff=sum(diag(conf))/t;
%eff(j)=sum(diag(conf))/t;
%m=m+1



%{
for j=1:10 
m1 = gmdistribution.fit(traindata{1},m,'Regularize',reg);
m2 = gmdistribution.fit(traindata{2},m,'Regularize',reg);
m3 = gmdistribution.fit(traindata{3},m,'Regularize',reg);
m4 = gmdistribution.fit(traindata{4},m,'Regularize',reg);
m5 = gmdistribution.fit(traindata{5},m,'Regularize',reg);
m6 = gmdistribution.fit(traindata{6},m,'Regularize',reg);
m7 = gmdistribution.fit(traindata{7},m,'Regularize',reg);
m8 = gmdistribution.fit(traindata{8},m,'Regularize',reg);
m9 = gmdistribution.fit(traindata{9},m,'Regularize',reg);
m10 = gmdistribution.fit(traindata{10},m,'Regularize',reg);

p1=pdf(m1,testdata);
p2=pdf(m2,testdata);
p3=pdf(m3,testdata);
p4=pdf(m4,testdata);
p5=pdf(m5,testdata);
p6=pdf(m6,testdata);
p7=pdf(m7,testdata);
p8=pdf(m8,testdata);
p9=pdf(m9,testdata);
p10=pdf(m10,testdata);

fProb = [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10];
[final,index]=max(fProb');

chec=[orig;index];
conf=confusionmat(orig,index);
t=size(testdata,1);
%eff=sum(diag(conf))/t;
eff(j)=sum(diag(conf))/t;
m=m+1
end
}%


%{
trainclass1=double(traindata{1});
testclass1=double(testdata{1});
data=[trainclass1;testclass1];
[coeff,score,l]=pca(data);
score=score(:,[1:100]);
train=score([1:5000],:);
test=score([5001:end],:);
%m1 = gmdistribution.fit(data,1,'Regularize',0.05);
m1 = fitgmdist(train, 2,'Regularize',0.5);

p1=pdf(m1,test);
%}