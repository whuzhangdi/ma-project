function [ newinformation, newret ] = ema( information,dailyreturn,emapara,short)
%wma Sumwmary of this function goes here
% [ newinformation, newret ] = wma( information,dailyreturn,5,0);
%% pre_strategy
newinformation=information;
[hang,~]=size(information);
newret=zeros(hang,1);
if hang<emapara || hang==emapara
    disp('error');
    return;
end;
for i=1:emapara
    newret(i,1)=0;
end;
%% ema strategy
emavalue = zeros(hang,1);
tradingrule = zeros(hang-1,1);
emavalue(1,1) = information(1,4);
for i=2:hang-1
    emavalue(i,1)=emavalue(i-1,1)*(1-1/emapara)+information(i,4)/emapara;
end;
%% trading signal
for i=2:hang-1
    if information(i,4)>emavalue(i,1)% buy
        if tradingrule(i,1)==-1
            tradingrule(i:hang,1)=0;
        else  
            tradingrule(i:hang,1)=1;
        end;
    end;
    if information(i,4)<emavalue(i,1)% sell
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

