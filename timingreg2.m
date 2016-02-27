function [ table ] = timingreg2( data,factors,rf )
%ALPHAREG compute one pannel alpha
%   example:[ table ] = alphareg( data,factors,rf )
%% compute the spread portfolio
for i=1:3
    dailyret=data.table.ma.info{i,2}-data.table.bah.info{i,2};
    [ analysisresult,cum_ret,iacmb] = pfmanalysis( data.table.ma.info{i,1},dailyret, rf );
    sen=0;
    %datatemp = data.table.ma.cum{i,1};
    datatemp=cum_ret;
    [hang,~]=size(datatemp);
    if hang>144
        hang = 144;
        sen=1;
        datatemp=datatemp(1:144);
    end;
    %% extract factors
    if sen==1
    %rf=rf(144-hang+1:144,:);
    factors=factors(144-hang+1:144,:);
    end;
%% generate the timing series
[hang,~] = size(factors);
factor = zeros(hang,2);
factor(:,1) = factors(:,1);
for j=1:hang 
    if factors(j,1)>0
        factor(j,2)=factors(j,1);
    else
        factor(j,2)=0;
    end;
end;
%% regress
%[ tempregstats ]=regstats2(datatemp,factor,'',{'tstat','rsquare'});
[hangsub,~]=size(datatemp);
factor=factor(hang-hangsub+1:hang,:);
tempregstats = regstats2(datatemp,factor,'linear',{'beta','r','tstat','hac'});
table(i*2-1,:) = tempregstats.beta(:)';
table(i*2,:) = tempregstats.hac.t(:)';
%disp(tempregstats.hac.pval(:)');
disp(tempregstats.tstat.pval(:)');
end;
end

