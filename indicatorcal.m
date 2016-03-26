function [indicator] = indicatorcal(cr,para)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
[hang,~] = size(cr);
if hang<para || hang<2
    indicator=nan*zeros(hang,1);
    return;
else
indicator = zeros(hang,1);
indicator(1,1) = nan;
indicator(2,1) = cr(2,1);
for i=3:hang
    indicator(i,1) = (cr(i,1)+indicator(i-1,1)*(para-1))/para;
end;
end;
end

