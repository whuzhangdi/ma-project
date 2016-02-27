function [ futures_series ] = adjustportfolio( futures_series )
%ADJUSTPORTFOLIO adjust the data: change nan in the data to zero,
% and add return rate to another array
% example: [ futures_series ] = adjustportfolio( futures_series );
[num_f,~]=size(futures_series);
for i=1:num_f
    [futures_series{i,1}] = nan2zero(futures_series{i,1});
    [hang,~] = size(futures_series{i,1});
    for j=1:hang-1
        futures_series{i,2}(j,1)=futures_series{i,1}(j+1,4)/futures_series{i,1}(j,4)-1;
    end;
    futures_series{i,2}(hang,1)=0;
end;
end

