function [ analysisresult,ia,cum_ret] = performanceanalysis( information,dailyreturn, rf)
%PERFORMANCEANALYSIS give monthly return,sd,sr,ske,kurtosis,t of return array
%example:[analysisresult] = performanceanalysis(information,dailyreturn,rf);
%%
analysisresult = zeros(1,8);
%%
[year,ia,~] = unique(information(:,1),'last');
ia=[1;ia];
[hang,~]=size(year);
cum_ret=zeros(hang,1);
for i=1:hang
    cum_ret(i,1)=prod(1+dailyreturn(ia(i):ia(i+1),:))-1;
end; 
rf_year = zeros(hang,1);
if hang==7 || hang==5
    rf=rf(144-hang*12+1:144,:);
end;
for i=1:hang
    rf_year(i,1)=prod(rf(12*i-11:12*i,:)+1)-1;
end;
%% compute statistics: daily frequency
temp=cum_ret-rf_year;
analysisresult(1,1)=mean(temp);
analysisresult(1,2)=std(temp);
analysisresult(1,3)=analysisresult(1,1)/analysisresult(1,2);
analysisresult(1,4)=skewness(temp);
analysisresult(1,5)=kurtosis(temp);
analysisresult(1,6)=mean(temp)*sqrt(hang)/std(temp);
analysisresult(1,7)=(1-cdf('t',abs(analysisresult(1,6)),hang-1))*2;
disp(analysisresult);
%%
temp=cum_ret-rf_year;
[hang,~] = size(temp);
%stats = regstats2(temp,zeros(hang,1),'linear',{ 'hac'})
[beta, X2_NW, std_NW,t_NW] = nwtest(temp,ones(hang,1),2);
analysisresult(1,1)=mean(temp);
analysisresult(1,2)=std(temp);
analysisresult(1,3)=mean(temp)/std(temp);
analysisresult(1,4)=skewness(temp);
analysisresult(1,5)=kurtosis(temp);
analysisresult(1,6)=t_NW;
analysisresult(1,7)=(1-cdf('t',abs(t_NW),hang-1))*2;
analysisresult(1,8)=mean(temp)*sqrt(hang)/std(temp);
disp(analysisresult);
end

