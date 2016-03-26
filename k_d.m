function [ newinformation, newret ] = k_d( information,dailyreturn,smapara,short)
%
% [ newinformation, newret ] = k_d( information,dailyreturn,{5,3});
%% pre_strategy
mapara = smapara{1};
kdjpara = smapara{2};
newinformation=information;
[hang,~]=size(information);
newret=zeros(hang,1);
if hang<mapara+kdjpara+1 || hang==mapara+kdjpara+1
    disp('error');
    return;
end;
if mapara<2
    disp('error');
    return;
end;
for i=1:mapara+kdjpara
    newret(i,1)=0;
end;
tradingrule = zeros(hang-1,3);%% kdj  trading_signal
%% kdj strategy
% compute k d value
for i=mapara:hang-1
    temp = newinformation(i-mapara+1:i,4);
    min_value = min(temp);
    max_value = max(temp);
    tradingrule(i,1) = (newinformation(i-1,4)-min_value)/(max_value-min_value);%k
end;
for i=mapara+kdjpara:hang-1
    tradingrule(i,2) = mean(tradingrule(i-kdjpara:i-1,1));%d
end;
%% trading signal
for i=mapara+kdjpara+1:hang-1
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

