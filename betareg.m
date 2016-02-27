function [ table ] = betareg( data,factors,rf )
%ALPHAREG compute one pannel alpha
%   example:[ table ] = alphareg( data,factors,rf )
for i=1:3
    sen=0;
    datatemp = data.table.ma.cum{i,1};
    [hang,~]=size(datatemp);
    if hang>144
        hang = 144;
        sen=1;
    end;
    %% extract factors
    if i==1
    rf=rf(144-hang+1:144,:);
    factors=factors(144-hang+1:144,:);
    end;
    %% extract ma return
    if sen
        datatemp1 = data.table.ma.cum{i,1}(1:144);
    else
        datatemp1 = data.table.ma.cum{i,1};
    end;
    %% extract bah return
if sen
    datatemp2 = data.table.bah.cum{i,1}(1:144);
else
    datatemp2 = data.table.bah.cum{i,1};
end;
%% regress
datatemp=datatemp1-datatemp2;
[ tempregstats ]=regstats(datatemp,factors(:,1:3),'',{'tstat','rsquare'});
table(i*2-1,:) = tempregstats.tstat.beta(:)';
table(i*2,:) = tempregstats.tstat.t(:)';
end;
end

