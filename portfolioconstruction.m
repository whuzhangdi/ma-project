function [ futures_series,futuremark ] = portfolioconstruction( futuresdata, num_f,lag)
% portfolio construction to construct continuous series adjusted by multiplier
% example:[ futures_series ] = portfolioconstruction( futuresdata, num_f,0);
%% pre construction
futures_series=cell(num_f,4);
maximum=zeros(num_f,400);
position=zeros(num_f,400);
futuresize=0;
%% construct portfolio series
futuremark=cell(num_f,1);
for i=1:num_f  % control kind
    %for i=8
    futuresdata{i,2}=sortrows(futuresdata{i,2},1); 
    [~,ia,~] = unique(futuresdata{i,2}(:,2),'last');
    ia=sort(ia);
    futuremark{i,1}=futuresdata{i,2}(ia,2);
    [num_fm,~]=size(futuremark{i,1});
    for j=1:num_fm % control month futures
        fstemp_f = zeros(300,1);
        n_f = 0;
        [hang_cell,~]=size(futuresdata{i,3});
        if j==1
            for k=1:hang_cell % control futures' rows
                if strcmpi(futuresdata{i,3}{k,2}(1,:),futuremark{i,1}{j,1}(1,:))
                    n_f=n_f+1;
                    fstemp_f(n_f,1)=k;
                    fstemp_f= fstemp_f(1:n_f,:);
                end;
            end;
            futures_series{i,1} = futuresdata{i,1}(fstemp_f,:);
            futures_series{i,1} = sortrows(futures_series{i,1},7);
            [futures_series{i,1}]=deletesamedata(futures_series{i,1},7);
            maximum(i,j) = max(futures_series{i,1}(:,7));
            [futuresize,~] = size(futures_series{i,1});
        else
           for k=1:hang_cell
                if strcmpi(futuresdata{i,3}{k,2}(1,:),futuremark{i,1}{j,1}(1,:))
                    n_f=n_f+1;
                    fstemp_f(n_f,1)=k;
                    fstemp_f= fstemp_f(1:n_f,:);
                end;
           end;
           % extract the same month future contracts
           futures_series_temp = futuresdata{i,1}(fstemp_f,:);
           futures_series_temp = sortrows(futures_series_temp,7);
           [futures_series_temp]=deletesamedata(futures_series_temp,7);
           % find the conjunction date
           position(i,j) = find(futures_series_temp(:,7)==(maximum(i,j-1)));
           position(i,j) = position(i,j)-lag;
           multiplier = futures_series{i,1}(futuresize,4)/futures_series_temp(position(i,j),4);  %
           %adj=futures_series{i,1}(futuresize,4)-futures_series_temp(position(i,j),4);   %%
           position_temp = find(futures_series_temp(:,7)>(maximum(i,j-1)));
           position_temp =  position_temp-lag;
           % extract the continuous data from the further month 
           cat_data = futures_series_temp(position_temp,:);
           cat_data(:,4) = cat_data(:,4)*1;%%%
           %cat_data(:,4) = cat_data(:,4)*multiplier;  %
           %cat_data(:,4) = cat_data(:,4)+adj;   %%
           % join the continuous data with predata
           futures_series{i,1}=[futures_series{i,1};cat_data];
           maximum(i,j) = max(futures_series{i,1}(:,7));
           [futuresize,~] = size(futures_series{i,1});
           %save('futuresnew.mat','futures_series');
        clear position_temp futures_series_temp cat_data;
        end;
    end;
end;
end