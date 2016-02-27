function [ table ] = alphareg( data,factors,rf )
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
    if i==1
    rf=rf(144-hang+1:144,:);
    factors=factors(144-hang+1:144,:);
    end;
    if sen
        datatemp = data.table.ma.cum{i,1}(1:144);
    else
        datatemp = data.table.ma.cum{i,1};
    end;
    datatemp=datatemp-rf;
[ tempregstats ]=regstats(datatemp,factors(:,1:3),'',{'tstat','rsquare'});
table(:,3+i) = tempregstats.tstat.beta(1);
tablet(:,3+i) = tempregstats.tstat.t(1);
if sen
    datatemp = data.table.bah.cum{i,1}(1:144);
else
    datatemp = data.table.bah.cum{i,1};
end;
datatemp=datatemp-rf;
[ tempregstats ]=regstats(datatemp,factors(:,1:3),'',{'tstat','rsquare'});
table(:,i) = tempregstats.tstat.beta(1);
tablet(:,i) = tempregstats.tstat.t(1);
end;
table=[table,tablet];
end

