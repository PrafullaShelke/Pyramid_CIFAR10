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
%k=500;
dataset=cell(10,1);
for i=1:10
    tmp=[];
    tmp=[double(traindata{i});double(testdata{i})];
    %[coeff,score,l]=pca(tmp);
    %score=score(:,[1:k]);
    datset{i}=tmp;
end

[traindata,testdata,sizevect] = datasetforgmm(datset');
trainset=[];
for i=1:10
    tmp=traindata{1};
    trainset=[trainset;tmp];
end
k=10;
[idx,C]=kmeans(trainset,k);

test_size=size(testdata,1);
final=[];
for i=1:test_size
    tmp=testdata(i,:);
    for j=1:k
        centre=C(j,:)
        dist=norm(tmp-centre);
        final(i,j)=dist;
    end
end
a=1;
for i=1:10
    n=sizevect(i);
    for k=1:n
        orig(a)=i;
        a=a+1;
    end
end

[fi,index]=min(final');

chec=[orig;index];
conf=confusionmat(orig,index);

t=size(testdata,1);
eff=sum(diag(conf))/t;

