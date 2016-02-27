function [ newinformation, newret ] = vma( information,dailyreturn,mapara,short)
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
for i=1:smapara+1
    newret(i,1)=0;
end;
tradingrule = zeros(hang-1,3);%% vma  trading_signal
%% vma strategy
% compute sma value
for i=fmapara+1:hang-1
    tradingrule(i,1)=sum(newinformation(i-fmapara:i-1,4))/fmapara;
end;
for i=smapara+1:hang-1
    tradingrule(i,2)=sum(newinformation(i-smapara:i-1,4))/smapara;
end;
%% trading signal
for i=smapara+2:hang-1
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

