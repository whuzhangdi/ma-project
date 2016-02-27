function [ futuresdata, num_f] = futuressortbykind( data_allall, data_txtall, dataall)
% sort all the futures data by kind,and ctreat the continuous series of each future
% example :[ futuresdata, num_f ] = futuressortbykind( data_allall, data_txtall,dataall);
%% pre_sort 
sortmark = unique(data_txtall(:,3));
[hang,lie] = size(dataall);
[num_f,~] = size(sortmark);
futures = cell(num_f,3);
fstemp = [];
n = 0;
%% sort data by kind 
for i=1:num_f
    for j=1:hang
        if strcmpi(data_allall{j,3}(1,:),sortmark{i,1}(1,:))
            n=n+1;
            fstemp(n,:)=j;
        end;
    end;
    futures{i,1}=dataall(fstemp,:);
    futures{i,2}=data_txtall(fstemp,:);
    futures{i,3}=data_allall(fstemp,:);
    fstemp = [];
    n = 0;
end;
%% fifth future's data is too short, delete 
futures(5,:)=futures(47,:);
futuresdata=futures(1:46,:);
sortmark(5,:)=sortmark(47,:);
sortmarkdata=sortmark(1:46,:);
num_f=num_f-1;
save('futures.mat','sortmarkdata','futuresdata');
end

