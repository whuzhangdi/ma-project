function [ newinformation, newret ] = macd( information,dailyreturn,mapara,short)
%vma Sumvmary of this function goes here
% [ newinformation, newret ] = vma( information,dailyreturn,5,0);
%% pre_strategy
fmapara = mapara{1};
smapara = mapara{2};
newinformation=information;
[hang,~]=size(information);
newret=zeros(hang,1);
if hang<smapara+2 || hang==smapara+2
    disp('error');
    return;
end;
newret(1,1)=0;
tradingrule = zeros(hang-1,3);%% macd  trading_signal
tradingrule(1,1) = information(1,4);
tradingrule(1,2) = information(1,4);
%% vma strategy
% compute sma value
for i=2:hang-1
    tradingrule(i,1)=tradingrule(i-1,1)*(1-1/fmapara)+information(i,4)/fmapara;
    tradingrule(i,2)=tradingrule(i-1,2)*(1-1/smapara)+information(i,4)/smapara;
end;
%% trading signal
for i=2:hang-1
    if tradingrule(i,1)-tradingrule(i,2)>0 && tradingrule(i-1,1)-tradingrule(i-1,2)<=0 % buy 
        if tradingrule(i,3)==-1
            tradingrule(i:hang-1,3)=0;
        else  
            tradingrule(i:hang-1,3)=1;
        end;
    end;
    if tradingrule(i,1)-tradingrule(i,2)<0 && tradingrule(i-1,1)-tradingrule(i-1,2)>=0  % sell
        if tradingrule(i,3)==1
            tradingrule(i:hang-1,3)=0;
        else  
            tradingrule(i:hang-1,3)=-1*short;
        end;
    end;
    newret(i,1)=dailyreturn(i,1)*tradingrule(i,3);
end;
newret(hang,1)=0;
save('trading.mat','tradingrule','newret');
end

