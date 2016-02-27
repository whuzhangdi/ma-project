function [ datanew ] = nan2zero( data )
%NAN2ZERO replace the nan in the array with zero
%example :[ datanew ] = nan2zero( data );
[hang,lie] = size(data);
para=0;
for i=1:hang
    for j=1:lie
        if isnan(data(i,j))
            datanew(i,j)=0;
        else
            datanew(i,j)=data(i,j);
        end;
    end;
end;
end

