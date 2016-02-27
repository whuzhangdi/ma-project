function [ newinformation, newret ] = roc( information,dailyreturn,rocpara,short)
%roc Sumrocry of this function goes here
% [ newinformation, newret ] = roc( information,dailyreturn,5,0);
%% pre_strategy
newinformation=information;
[hang,~]=size(information);
newret=zeros(hang,1);
if hang<rocpara+2 || hang==rocpara+2
    disp('error');
    return;
end;
for i=1:rocpara+3
    newret(i,1)=0;
end;
tradingrule = zeros(hang-1,2);%% ROC  trading_signal
%% roc strategy
% compute roc value
for i=rocpara+2:hang-1
    tradingrule(i,1)=information(i,4)/information(i-rocpara-1,4);
end;
% trading signal
for i=rocpara+3:hang-1
    if tradingrule(i,1)>1 && tradingrule(i-1,1)<=1 % buy 
        if tradingrule(i,2)==-1
            tradingrule(i:hang-1,2)=0;
        else  
            tradingrule(i:hang-1,2)=1;
        end;
    end;
    if tradingrule(i,1)<1 && tradingrule(i-1,1)>=1  % sell
            if tradingrule(i,2)==1
                tradingrule(i:hang-1,2)=0;
            else
                tradingrule(i:hang-1,2)=-1*short;
            end;
    end;
    newret(i,1)=dailyreturn(i,1)*tradingrule(i,2);
end;
newret(hang,1)=0;
save('trading.mat','tradingrule','newret');
end

