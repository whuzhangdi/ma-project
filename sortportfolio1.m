function [ temp_mark ] = sortportfolio1( cellwithfactor,fctpos )
%SORTPORTFOLIO sort portfolio within month,tradingvlm,openinst,voltlt 
% 1:low 2:middle 3:high 0:no data
%example:[ sortresult ] = sortportfolio1( cellwithfactor,5);
[num_f,~] = size(cellwithfactor);
%% find the maximum length in term of month
max_length = 0;
for i=1:num_f
    [hang,~]=size(cellwithfactor{i,fctpos});
    if hang>max_length
        max_length=hang;
    end;
end;
%% rank the factors in desascend order
tempcmb=[];
for i=1:num_f
    temp = cellwithfactor{i,fctpos};
    [hang,~] = size(temp);
    if i==26|i==30 % num_f=26 or 30, start data is 2003-1-2
        for j=1:hang
            tempcmb(j,i) = temp(j,1);
        end;
        for j=hang+1:max_length
            tempcmb(j,i) = nan;
        end;
    else
    for j=1:max_length-hang
        tempcmb(j,i) = nan; % different form 0 in the raw data
    end;
    for j=max_length+1-hang:max_length
        tempcmb(j,i)=temp(j-max_length+hang,1);
    end;
    end;
end;
%% mark the factors in term of month,three
[hang,lie]=size(tempcmb);
temp_mark=zeros(hang,lie);
for i=1:hang
    tempdata = tempcmb(i,:);
    sentence = ~isnan(tempdata);
    num_nnan = sum(sentence);
    position = find(sentence==1);
    [~,array]=sort(tempdata(:,position));
    for j=1:num_nnan
        pos = array(1,j);
        tmp = position(1,pos);
        if j<ceil(num_nnan/3) % 5 contracts:2 1 2
            temp_mark(i,tmp)=1;% 1:low 
        else
            if j>floor(2*num_nnan/3)
                temp_mark(i,tmp)=3;% 3:high
                %temp_mark(i,position(1,array(1,j)))=3;
            else
                temp_mark(i,tmp)=2;% 2:middle
                %temp_mark(i,position(1,array(1,j)))=2:% 2:middle
            end;
        end;
    end;
end; 
end

