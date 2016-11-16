function [ traindata ] = makedata( batch1 ,traindata)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

x=batch1.data;
y=batch1.labels;
n=size(x,1);
for i=1:n
   tmp=x(i,:);
   index=y(i);
   index=index+1;
   tmp1=traindata{index};
   tmp1=[tmp1;tmp];
   traindata{index}=tmp1;
end
end

