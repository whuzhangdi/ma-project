function [ bootstrap_result,mean,shpratio ] = bootstrap(sortresult ,para)
%BOOTSTRAP extract futures information randomly,and number the simulated return worse than the real return 
%   example:[ bootstrap_result,mean,shpratio ] = bootstrap(sortresult,{5,10,1,0,1000});
%   written by; zd
%% initialization
tic;
fma = para{1};% para
sma = para{2};
year = para{3};
short = para{4};
strappara = para{5};
bootstrap_result = cell(strappara+1,1);
load('factors_new.mat');% riskfree rate
new_dataset = sortresult; 
new_dataset = rmfield(new_dataset,'information'); % delete redunent information
new_dataset.vlm = rmfield(new_dataset.vlm,'vlm_mark');
new_dataset.vltlt = rmfield(new_dataset.vltlt,'vltlt_mark');
new_dataset.openinst = rmfield(new_dataset.openinst,'openinst_mark');
new_dataset.lastmon = rmfield(new_dataset.lastmon,'lastmon_mark');
new_dataset.sixmonth = rmfield(new_dataset.sixmonth,'sixmonth_mark');
new_dataset.sixtymonth = rmfield(new_dataset.sixtymonth,'sixtymonth_mark');
%% bootstraping
for j=1:strappara
    if j==floor(strappara/2)
        disp('half complete!');
    end;
    %generate new dataset
    for i=1:3
        [hang_sub,~] = size(sortresult.vlm.rslt{i,2});
        mark = randi(hang_sub,hang_sub,1);
        new_dataset.vlm.rslt{i,2} = sortresult.vlm.rslt{i,2}(mark(1:hang_sub),1);
        new_dataset.vlm.rslt{i,1}(:,5) = sortresult.vlm.rslt{i,1}(mark(1:hang_sub),5);
        [new_dataset.vlm.rslt{i,1}(:,4)] = ret2price(sortresult.vlm.rslt{i,2}(mark(1:hang_sub),1));
        
        [hang_sub,~] = size(sortresult.vltlt.rslt{i,2});
        mark = randi(hang_sub,hang_sub,1);
        new_dataset.vltlt.rslt{i,2} = sortresult.vltlt.rslt{i,2}(mark(1:hang_sub),1);
        new_dataset.vltlt.rslt{i,1}(:,5) = sortresult.vltlt.rslt{i,1}(mark(1:hang_sub),5);
        [new_dataset.vltlt.rslt{i,1}(:,4)] = ret2price(sortresult.vltlt.rslt{i,2}(mark(1:hang_sub),1));
    
        [hang_sub,~] = size(sortresult.openinst.rslt{i,2});
        mark = randi(hang_sub,hang_sub,1);
        new_dataset.openinst.rslt{i,2} = sortresult.openinst.rslt{i,2}(mark(1:hang_sub),1);
        new_dataset.openinst.rslt{i,1}(:,5) = sortresult.openinst.rslt{i,1}(mark(1:hang_sub),5);
        [new_dataset.openinst.rslt{i,1}(:,4)] = ret2price(sortresult.openinst.rslt{i,2}(mark(1:hang_sub),1));
        
        [hang_sub,~] = size(sortresult.lastmon.rslt{i,2});
        mark = randi(hang_sub,hang_sub,1);
        new_dataset.lastmon.rslt{i,2} = sortresult.lastmon.rslt{i,2}(mark(1:hang_sub),1);
        new_dataset.lastmon.rslt{i,1}(:,5) = sortresult.lastmon.rslt{i,1}(mark(1:hang_sub),5);
        [new_dataset.lastmon.rslt{i,1}(:,4)] = ret2price(sortresult.lastmon.rslt{i,2}(mark(1:hang_sub),1));
        
        [hang_sub,~] = size(sortresult.sixmonth.rslt{i,2});
        mark = randi(hang_sub,hang_sub,1);
        new_dataset.sixmonth.rslt{i,2} = sortresult.sixmonth.rslt{i,2}(mark(1:hang_sub),1);
        new_dataset.sixmonth.rslt{i,1}(:,5) = sortresult.sixmonth.rslt{i,1}(mark(1:hang_sub),5);
        [new_dataset.sixmonth.rslt{i,1}(:,4)] = ret2price(sortresult.sixmonth.rslt{i,2}(mark(1:hang_sub),1));
        
        [hang_sub,~] = size(sortresult.sixtymonth.rslt{i,2});
        mark = randi(hang_sub,hang_sub,1);
        new_dataset.sixtymonth.rslt{i,2} = sortresult.sixtymonth.rslt{i,2}(mark(1:hang_sub),1);
        new_dataset.sixtymonth.rslt{i,1}(:,5) = sortresult.sixtymonth.rslt{i,1}(mark(1:hang_sub),5);
        [new_dataset.sixtymonth.rslt{i,1}(:,4)] = ret2price(sortresult.sixtymonth.rslt{i,2}(mark(1:hang_sub),1));
    end;
    % carry out the strategy on new dataset
    [new_dataset] = ma_six(new_dataset,{fma,sma,year,short},rf);
    bootstrap_result{j,1} = new_dataset;
end;
[new_dataset] = ma_six(sortresult,{fma,sma,year,short},rf);
bootstrap_result{strappara+1,1} = new_dataset;
%% statistics
[mean,shpratio] = number_result(bootstrap_result);
toc;
end

