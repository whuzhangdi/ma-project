function [alpha,rsquare,pvalue,bta,p_bta] = capm_alpha(mon_ret,factors,rf)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
[~,lie]=size(mon_ret);
alpha = zeros(lie,1);
rsquare = zeros(lie,1);
pvalue = zeros(lie,1);
bta = zeros(lie,1); 
p_bta = zeros(lie,1);
for i=1:lie
    temp = mon_ret(:,i);
    mark = find(isnan(temp));
    [pos,~]=size(mark);
    temp = temp(pos+1:144);
    rfs = rf(pos+1:144);
    cons = ones(144-pos,1);
    factor = [cons,factors(pos+1:144,:)];
    [~,k]=size(factor);
    [beta, ~, ~,  t_NW,R2adj] = nwtest2(temp-rfs,factor,4);
    alpha(i,1)=beta(1,1);
    pvalue(i,1)=(1-cdf('t',abs(t_NW(1,1)),144-k))*2;
    rsquare(i,1)=R2adj;
    bta(i,1)=beta(2,1);
    p_bta(i,1)=(1-cdf('t',abs(t_NW(2,1)),144-k))*2;
end;
end
