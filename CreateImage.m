data=load('E:\IIT KGP\ML Project\datasets\CIFAR10_matlab\data_batch_1');
x=data.data;
labels=data.labels;
n=size(x,1);
for j=1:n
    l=labels(j)
    y=x(j,:);
    r=y(:,[1:1024]);
    g=y(:,[1025:2048]);
    b=y(:,[2049:3072]);
    finalr=[];
    finalg=[];
    finalb=[];
    c=1;
    for i=1:32
        tmp=r(:,[c:32*i]);
        finalr=[finalr;tmp];
        tmp=g(:,[c:32*i]);
        finalg=[finalg;tmp];
        tmp=b(:,[c:32*i]);
        finalb=[finalb;tmp];
        c=c+32;
    end
    B = cat(3, finalr, finalg, finalb);
   imname=strcat(num2str(j),'.jpg');
   path='E:\IIT KGP\ML Project\datasets\CIFAR10_matlab\batch1';
   %s=strcat(path,num2str(l),'\',imname);
   s=strcat(path,'\',imname);

    imwrite(B,s);
    
end