function [ cum_ret ] = day2month( information,dailyreturn )
% function: calculated the daily return to monthly return
%   [ cum_ret ] = day2month( information,dailyreturn )
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
end

