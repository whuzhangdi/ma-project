function [ result_series ] = reconstruction1( information,fct_mark,para )
%RECONSTRUCTION reconstruct future portfolio series according to factors
% example: [sortresult.vlm]=reconstruction1(sortresult.information,sortresult.vlm_mark,3);
[hang,lie] = size(fct_mark);
result_series = cell(para,2);
month_maxs=zeros(hang,para);
%% reconstruction 
for k=1:para % control sort
    retcmbcmb = [];
    informationcmb = [];
for i=1:hang  % control month
    tempmark = fct_mark(i,:);
    pos1 = find(tempmark==k);
    [~,lie] = size(pos1);
    month_num = zeros(lie,1);
    datecmb = [];
    for j=1:lie % cotrol contract
        temppos = pos1(j);
        temp = information{temppos,4};
        [hang_pos,~] = size(temp);
        if temppos==26|temppos==30
            position = information{temppos,4}(i:i+1,:);
        else
            position = information{temppos,4}(i+hang_pos-1-hang:i+hang_pos-hang,:);
        end;
        date =  information{temppos,1}(position(1)+1:position(2),7);
        datecmb = [datecmb;date];
        month_num(j,1) = position(2)-position(1);
    end;
    month_max = max(month_num);
    %month_maxs(i,k) = month_max;
    datecmb = unique(datecmb);
    [num_day,~] = size(datecmb);
    retcmb = zeros(num_day,lie);
    informations = [];
    for j=1:num_day
        indate = datecmb(j);
        tempinfo = datevec(indate);
        informations = [informations;tempinfo(:,1:4)]; 
        for n=1:lie
            temppos = pos1(n);
            tempret = information{temppos,2};
            tempdate = information{temppos,1}(:,7);
            retpos = find(tempdate==indate);
            if numel(retpos) 
                retcmb(j,n)=tempret(retpos,1);
            else 
                retcmb(j,n)=nan;
            end;
        end;
    end;
    retcmb=nanmean(retcmb,2);
    retcmbcmb=[retcmbcmb;retcmb];
    informationcmb = [informationcmb;informations];
end;
[hanga,~]=size(informationcmb);
informationcmb(1,4)=100;
for ii=2:hanga
    informationcmb(ii,4)=(retcmbcmb(ii-1,1)+1)*informationcmb(ii-1,4);
end;
result_series{k,2}=retcmbcmb;
result_series{k,1}=informationcmb;    
end;
end

