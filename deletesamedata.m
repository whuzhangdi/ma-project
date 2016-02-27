function [ datanew ] = deletesamedata( data ,para)
%delete the same data in the array
%example:[ datenew ] = deletesamedata( data,7 );
[hang,lie] = size(data);
pos=para;
datanew=zeros(hang,lie);
if isnan(data)
    disp('error');
    return;
end;
n=1;
datanew(1,:)=data(1,:);
for i=2:hang
    if data(i,para)~=data(i-1,para)
        n=n+1;
        datanew(n,:)=data(i,:);
    end;
end;
datanew=datanew(1:n,:);
end

