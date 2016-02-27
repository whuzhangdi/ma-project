function [ newinformation, newret ] = ma( information,dailyreturn,mapara,short)
%MA Summary of this function goes here
% [ newinformation, newret ] = ma( information,dailyreturn,5,0);
%% pre_strategy
newinformation=information;
[hang,~]=size(information);
newret=zeros(hang,1);
if hang<mapara || hang==mapara
    disp('error');
    return;
end;
for i=1:mapara-1
    newret(i,1)=0;
end;
%% ma strategy
for i=mapara:hang-1
    mavalue=(sum(information(i-mapara+1:i,4)))/mapara;
    if information(i,4)>mavalue
        newret(i,1)=dailyreturn(i,1);
    else 
        if short==1
            newret(i,1)=-dailyreturn(i,1);
        else
            newret(i,1)=0;
        end;
    end;
end;
newret(hang,1)=0;
end

