function [ cellwithfactor ] = factorcompute( futures_series,cumpara)
%FACTORCOMPUTE compute the six sorting factors,
% which are daily volatility,daily trading volume:5,daily open interest:6,return,volatility,mom
%  [ cellwithfactor ] = factorcompute( futures_series,{6,60});
%% pre-computation
pricedata = futures_series(:,1:2);
[num_f,~] = size(pricedata);
cellwithfactor = cell(num_f,10);
cellwithfactor(:,1:2) = pricedata;
shortpara=cumpara{1};
longpara=cumpara{2};
%% find the month position in the array and compute the 
for i=1:num_f
    %for i=2:2
    [year,ia,~]=unique(pricedata{i,1}(:,1),'last');
    ia=[0;ia];
    cellwithfactor{i,3}(:,2)=ia;
    [hang,~]=size(year);
    %cellwithfactor{i,3}(2:hang+1,1)=year;
    iacmb=[];
    for j=1:hang
        [~,iamon,~]=unique(pricedata{i,1}(ia(j)+1:ia(j+1),2),'last');%%
        iamon=ia(j)+iamon;
        iacmb=[iacmb;iamon];
    end;
    iacmb=[0;iacmb];
    cellwithfactor{i,4}=iacmb;
    [hang_cmp,~]=size(iacmb);
    for k=1:hang_cmp-1
        tempprice = pricedata{i,1}(iacmb(k)+1:iacmb(k+1),:);
        tempret =  pricedata{i,2}(iacmb(k)+1:iacmb(k+1),:);
        dailytradingvolume = mean(tempprice(:,5));
        dailyopeninterest = mean(tempprice(:,6));
        dailyvolitility = std(tempret);
        monthreturn = prod(tempret+1)-1;
        cellwithfactor{i,5}(k,1) = dailytradingvolume;
        cellwithfactor{i,6}(k,1)= dailyopeninterest;
        cellwithfactor{i,7}(k,1) = dailyvolitility;
        cellwithfactor{i,8}(k,1) = monthreturn;
        if k>1
            cellwithfactor{i,8}(1,2) = nan;
            cellwithfactor{i,8}(k,2) = cellwithfactor{i,8}(k-1,1);%save the last month ret
        end;
        if k>shortpara
            cellwithfactor{i,8}(1:shortpara,3) = nan;
            cellwithfactor{i,8}(k,3) = prod(cellwithfactor{i,8}(k-shortpara:k-1,1)+1)-1;%save the last six months ret
        end;
        if k>longpara
            cellwithfactor{i,8}(1:longpara,4) = nan;
            cellwithfactor{i,8}(k,4) = prod(cellwithfactor{i,8}(k-longpara:k-1,1)+1)-1;%save the last sixty months ret
        end;
    end;
    [~,lie]=size(cellwithfactor{i,8});
    if lie<2
        disp('length smaller than one month');
        disp(i);
    end;
    if lie<3
        disp('length smaller than shortpara');
        disp(i);
    end;
    if lie<4
        disp('length smaller than longpara');
        disp(i);
    end;
end;
end

