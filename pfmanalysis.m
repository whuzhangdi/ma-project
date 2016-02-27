function [ analysisresult,cum_ret,iacmb] = pfmanalysis( information,dailyreturn, rf )
%PERFORMANCEANALYSIS give monthly return,sd,sr,ske,kurtosis,t of return array
%example:[analysisresult] = pfmanalysis(information,dailyreturn,rf);
%% pre-preparation
analysisresult = zeros(1,8);
%% 
[year,ia,~]=unique(information(:,1),'last');
ia=[1;ia];
[hang,~]=size(year);
cmonth=cell(hang,1);
iacmb=[];
adj=0;
for i=1:hang
    [cmonth{i,1},iamon,~]=unique(information(ia(i):ia(i+1),2),'last');
    iamon=iamon+adj;
    iacmb=[iacmb;iamon];
    if i<hang
    adj=ia(i+1);
    end;
end;
if iacmb(1,1)==1
    iacmb=iacmb-1;
    iacmb(1,1)=1;
else
    iacmb=iacmb-1;
    iacmb=[1;iacmb];
end;
clear ia hang;
[hang,lie]=size(iacmb);
cum_ret=zeros(hang,1);
for i=1:hang-1
    cum_ret(i,1)=prod(1+dailyreturn(iacmb(i):iacmb(i+1),:))-1;
end; 
cum_ret=cum_ret(1:hang-1,:);
%% compute statistics: daily frequency
%temp=cum_ret-rf/12;
temp=cum_ret-rf(144-(hang-1)+1:144,:);
[hang,~] = size(temp);
%stats = regstats2(temp,zeros(hang,1),'linear',{ 'hac'})
[beta, X2_NW, std_NW,t_NW] = nwtest(temp,ones(hang,1),2);
analysisresult(1,1)=mean(temp)*12;
analysisresult(1,2)=std(temp)*sqrt(12);
analysisresult(1,3)=mean(temp)/std(temp);
analysisresult(1,4)=skewness(temp);
analysisresult(1,5)=kurtosis(temp);
analysisresult(1,6)=t_NW;
analysisresult(1,7)=(1-cdf('t',abs(t_NW),hang-1))*2;
analysisresult(1,8)=mean(temp)*sqrt(hang)/std(temp);
disp(analysisresult);
end

