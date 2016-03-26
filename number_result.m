function [ret,sr] = number_result(result)
%number_result count the number of strategy outforming the benchmark
%   example:[mean,shpratio] = number_result(bootstrap_result);
%% initailization
[strappara,~] = size(result);
ret = cell(9,1);
sr = cell(9,1);
for i=1:9
    ret{i,1}=zeros(strappara,18);
    sr{i,1}=zeros(strappara,18);
end;
stragetyname= {'bah','roc','wma','ema','macd','vma','k_d','s_r','obv'};
sortedname = {'vltlt','vlm','openinst','lastmon','sixmonth','sixtymonth'};
%% extract data
for i=1:strappara
    n=0;
    for j=1:6
        tempdata=getfield(getfield(result{i,1},sortedname{1,j}),'table');
        for k=1:9
            temptable = getfield(getfield(tempdata,stragetyname{1,k}),'table');
            ret{k,1}(i,j*3-2:j*3)=temptable(:,1)';
            sr{k,1}(i,j*3-2:j*3)=temptable(:,3)';
        end;
    end;
end;
%% calculte mean of ret and sr
for i=1:9
    retmeantable(:,i)=mean(ret{i,1}(1:strappara-1,:))';%18 9
    srmeantable(:,i)=mean(sr{i,1}(1:strappara-1,:))';% 18 9
    number_lie = zeros(strappara-1,18);
    for j=1:strappara-1
        number_lie(j,:) = (ret{i,1}(j,:)<ret{i,1}(strappara,:));
    end;
    numtable(:,i) = sum(number_lie)'; % worse than the ture performance, 18 9
end;
for i=2:9
    rettable(1,i)=mean(sum(ret{i,1}>ret{1,1},2));
    srtable(1,i)=mean(sum(sr{i,1}>sr{1,1},2));
end;
[hang,lie] = size(retmeantable);
table = zeros(hang*3+2,lie);
for i=1:hang
    table(i*3-2,:)=retmeantable(i,:);
    table(i*3-1,:)=srmeantable(i,:);
    table(i*3  ,:)=numtable(i,:);
end;
table(hang*3+1,:) = rettable;
table(hang*3+2,:) = srtable;
xlswrite('D:\program files\matlab\bin\maproject_english\bootstrap.xls',table,'Sheet1','D2');
xlswrite('D:\program files\matlab\bin\maproject_english\bootstrap.xls',datevec(now),'Sheet1','A58');
disp('complete!');
end

