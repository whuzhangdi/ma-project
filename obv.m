function [ newinformation, newret ] = obv( information,dailyreturn,smapara,short)
%vma Sumvmary of this function goes here
% [ newinformation, newret ] = obv( information,dailyreturn,5,0);
%% pre_strategy
mapara = smapara{1};
%kdjpara = smapara{2};
newinformation=information;
[hang,~]=size(information);
newret=zeros(hang,1);
if hang<mapara+2 || hang==mapara+2
    disp('error');
    return;
end;
for i=1:mapara+2
    newret(i,1)=0;
end;
tradingrule = zeros(hang-1,3);%% obv sma(obv) trading_signal
%% obv strategy
% compute obv value
for i=2:hang-1
    if newinformation(i,4)>newinformation(i-1,4)
        tradingrule(i,1)=tradingrule(i-1,1)+newinformation(i,5);
    end;
    if newinformation(i,4)==newinformation(i-1,4)
        tradingrule(i,1)=tradingrule(i-1,1);
    end;
    if newinformation(i,4)<newinformation(i-1,4)
        tradingrule(i,1)=tradingrule(i-1,1)-newinformation(i,5);
    end;
end;
for i=mapara+2:hang-1
    tradingrule(i,2) = mean(tradingrule(i-mapara:i-1,1));
end;
%% trading signal
for i=mapara+3:hang-1
    if tradingrule(i,1)>tradingrule(i,2) && tradingrule(i-1,1)<=tradingrule(i-1,2) % buy 
        if tradingrule(i,3)==-1
            tradingrule(i:hang-1,3)=0;
        else  
            tradingrule(i:hang-1,3)=1;
        end;
    end;
    if tradingrule(i,1)<tradingrule(i,2) && tradingrule(i-1,1)>=tradingrule(i-1,2)  % sell
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

