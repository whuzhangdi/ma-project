function [data_trdnum]=selectbyyear(data,mark)
%UNTITLED4 Summary of this function goes here
%   [data_num]=selectbyyear(data);
%   [ma2_num]=selectbyyear(ma2);
%% 数据准备
[hangsub,~]=size(mark);
data_temp = cell(hangsub-1,1);
space = zeros(hangsub-1,1);
for i=1:hangsub-1
    if hangsub==1
        startpoint = mark(i,1);
    else 
        startpoint = mark(i,1)+1;
    end;
    endpoint = mark(i+1,1);
    temp = data(startpoint:endpoint,:);
    [space(i,1),~] = size(temp);
    data_temp{i,1} = temp;
end;
hang = min(space);
lie = hangsub-1;
data_trdnum = zeros(hang,lie);
for i=1:hangsub-1
    data_adj(:,i) = data_temp{i,1}(1:hang,:);
end;

end

