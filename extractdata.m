function [ moninformation] = extractdata( information,para)
% function: change the frenquency of data to month, that's daily data to
% monthly data
% information:year month day price trading-volume
% example:[ sortresult.vlm.monrslt] = extractdata( sortresult.vlm.rslt);
for i=1:3
    if para==5
        [ moninformation{i,1},moninformation{i,2} ] = extractprice2( information{i,1},information{i,2}); %week
    else
        [ moninformation{i,1} ] = extractprice( information{i,1});% month
        [ moninformation{i,2} ] = day2month( information{i,1},information{i,2} );
    end;
end;
end

