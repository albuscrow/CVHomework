addpath('./sift');

for i=1:10000
    temp=x_train(:,i);
    tempnum=y_train(:,i);
    tempimg=reshape(temp,28,28);
    
    [frames,descr,gss,dogss] = sift(tempimg) ;
    [~,col]=size(descr);
    for j=1:col
        siftnum=[siftnum,y_train(i)];
        sift128=[sift128,descr(:,j)];
    end
end

% π”√kmeansÀ„∑®£¨k=30;
[row,col]=size(sift128);
k=30;

center=sift128(:,1:k);
stu=true;
while(stu)
    temp=zeros(128,k);
    tempnum=zeros(1,k);
    dis=zeros(1,k);
    for i=1:col
        for j=1:k
            tempdis=sift128(:,i)-center(:,j);
            tempdis=tempdis.*tempdis;
            dis(j)=sum(tempdis);
        end
        [temp,mindis]=min(dis);
        
        temp(:,mindis)=temp(:,mindis)+sift128(:,i);
        tempnum(mindis)=tempnum(mindis)+1;
    end
    
    mydis=0;
    for i=1:k
        temp(:,i)=temp(:,i)/tempnum(i);
        temp=temp(:,i)-center(:,i);
        temp=temp.*temp;
        mydis=mydis+sum(temp);
    end
    
    if mydis<0.0001
        stu=false;
    end
    
    center=temp;
end

centertemp=zeros(1,col);
for i=1:col
   temp=sift128(:,i);
   dis=ones(1,k);
   for j=1:k
       distemp=temp-center(:,j);
       distemp=distemp.*distemp;
       dis(j)=sum(distemp);
    end
    [ temptemp,mindis]=min(dis);
    centertemp(i)=mindis;
end

centernum=zeros(1,k);
temp=zeros(10,k);
for i=1:col
    temp(siftnum(i)+1,centertemp(i))=temp(siftnum(i)+1,centertemp(i))+1;
end
for i=1:k
    temp=temp(:,i);
    [ temptemp,maxtemp]=max(temp);
    centernum(i)=maxtemp-1;
end

correct=0;
% find point and test
for i=1:500
    temp=x_train(:,i);
    tempnum=y_train(:,i);
    tempimg=reshape(temp,28,28);
    
    [frames,descr,gss,dogss] = sift(tempimg) ;
    [row,col]=size(descr);
    temp=zeros(1,10);
    for j=1:col
        belong=1;
        tempmin=0;
        for ii=1:k
            temp=descr(:,j)-center(:,ii);
            temp=temp.*temp;
            dis=sum(temp);
            if ii==1
               tempmin=dis;
            else
                if tempmin>dis
                    dis=tempmin;
                    belong=ii;
                end
            end
        end
        temp(centernum(belong)+1)=temp(centernum(belong)+1)+1;
    end
    [ temptemp,maxtemp]=max(temp);
    if maxtemp-1==y_train(i);
        correct=correct+1;
    end
end
correct/500
