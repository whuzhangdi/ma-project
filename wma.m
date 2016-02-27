function [ newinformation, newret ] = wma( information,dailyreturn,wmapara,short)
%wma Sumwmary of this function goes here
% [ newinformation, newret ] = wma( information,dailyreturn,5,0);
%% pre_strategy
newinformation=information;
[hang,~]=size(information);
newret=zeros(hang,1);
if hang<wmapara || hang==wmapara
    disp('error');
    return;
end;
for i=1:wmapara
    newret(i,1)=0;
end;
%% wma strategy
n_hat = [1:wmapara];
weight = n_hat./sum(n_hat);
wmavalue = zeros(hang,1);
tradingrule = zeros(hang-1,1);
for i=wmapara:hang-1
    wmavalue(i,1)=information(i-wmapara+1:i,4)'*weight';
end;
%% trading signal
for i=wmapara+1:hang-1
    if information(i,4)>wmavalue(i,1)% buy
        if tradingrule(i,1)==-1
            tradingrule(i:hang,1)=0;
        else  
            tradingrule(i:hang,1)=1;
        end;
    end;
    if information(i,4)<wmavalue(i,1)% sell
        if tradingrule(i,1)==1
            tradingrule(i:hang,1)=0;
        else  
            tradingrule(i:hang,1)=-1*short;
        end;
    end;
    newret(i,1)=dailyreturn(i,1)*tradingrule(i,1);
end;
newret(hang,1)=0;
end

