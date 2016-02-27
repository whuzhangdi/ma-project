function [ table ] = betareg2( data,factors,rf )
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
    if i==1
    rf=rf(144-hang+1:144,:);
    factors=factors(144-hang+1:144,:);
    end;
%% regress
[ tempregstats ]=regstats(datatemp,factors(:,1:3),'',{'tstat','rsquare'});
table(i*2-1,:) = tempregstats.tstat.beta(:)';
table(i*2,:) = tempregstats.tstat.t(:)';
end;
end

