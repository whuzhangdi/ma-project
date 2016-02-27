function [ marketindex,mktfactors,date_index] = futuremarkrt_index( celldata )
%根据CFCCM公布的指数权重计算2012年以前的组合指数
%  调用示例:[ marketindex,mktfactors,date_index ] = futuremarkrt_index(sortresult.information);
%% pre computation
[hang,~] = size(celldata);
weight = [40	37	36	35	22	6	5	12	11	2	1	42	41	45	18]';
kind = [0.2062 	0.0711 	0.1090 	0.0834 	0.1034 	0.0648 	0.0360 	0.0394 	0.0774 	0.0246 	0.0218 	0.0579 	0.0468 	0.0362 	0.0218 ]';
[hang_sub,~] = size(weight);
[hang_sub2,~] = size(kind);
if hang_sub~=hang_sub2
    disp('error!');
end;
%% construction
% select the longgest trading futures kind 
day_num = zeros(hang,1);
for i=1:hang
    [day_num(i,1),~]=size(celldata{i,1});
end;
[hang_max,max_pos]=max(day_num);
index_date = zeros(hang_max,4);
index_date(:,1:3) = [celldata{max_pos,1}(:,1:3)];
date_index = celldata{max_pos,1}(:,7);
index_matrix = zeros(hang_max,hang_sub);% put all the price of all kind futures 
index_missing =  zeros(hang_max,hang_sub);% price exist/missing:[1/0];
% select the price
for i=1:hang_max
    for j=1:hang_sub
        tempdata = celldata{weight(j,1),1};
        pos = find(tempdata(:,7)==date_index(i));
        [pos_num,~]=size(pos);
        if pos_num==0
            index_matrix(i,j)=nan;
        else
            index_matrix(i,j)=tempdata(pos,4);
            index_missing(i,j)=1;
        end;
    end;
end;
% compute index 
for i=1:hang_max
    weight_adj = index_missing(i,:).*weight';
    weight_adj = weight_adj/sum(weight_adj); % standardise
    index_date(i,4)=nansum(weight_adj.*index_matrix(i,:));
end;
% 
[index_real] = xlsread('D:\program files\matlab\bin\maproject_english\index_real.xls','Sheet1');
[trans_pos] = find(date_index==index_real(1,6));
index_date(:,4)=1000*index_date(:,4)/index_date(trans_pos,4);% 2012.1.10 standardise
index_date(trans_pos:hang_max,:)=index_real(:,1:4);
disp(trans_pos);
%[index_real] = textread('D:\program files\matlab\bin\maproject_english\index.xls');
% compute daily return
daily_ret=zeros(hang_max,1);
for i=2:hang_max
    daily_ret(i,1)=index_date(i,4)/index_date(i-1,4)-1;
end;
% compute factor
load factors.mat;
[ ~,mon_ret,~] = pfmanalysis( index_date,daily_ret, rf );
mktfactors = mon_ret-rf;
marketindex = index_date;
end

