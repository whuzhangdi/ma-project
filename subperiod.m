function [sortresult1,sortresult2] = subperiod(sortresult)
%break the whole sample into two sub-period according to financial crisis
%   [sortresult1,sortresult2] = subperiod(sortresult);
sortresult1=[];
sortresult2=[];
%% vlm vltlt openinst
break1 = 1212;
for i=1:3
    for j=1:2
        [hang,~]=size(sortresult.vlm.rslt{i,j});
        sortresult1.vlm.rslt{i,j}=sortresult.vlm.rslt{i,j}(1:break1-1,:);
        sortresult2.vlm.rslt{i,j}=sortresult.vlm.rslt{i,j}(break1:hang,:);
    end;
end;
for i=1:3
    for j=1:2
        if i==1
            break1=1211;
        else 
            break1=1212;
        end;
        [hang,~]=size(sortresult.openinst.rslt{i,j});
        sortresult1.openinst.rslt{i,j}=sortresult.openinst.rslt{i,j}(1:break1-1,:);
        sortresult2.openinst.rslt{i,j}=sortresult.openinst.rslt{i,j}(break1:hang,:);
    end;
end;
break1 = 1212;
for i=1:3
    for j=1:2
        [hang,~]=size(sortresult.vltlt.rslt{i,j});
        sortresult1.vltlt.rslt{i,j}=sortresult.vltlt.rslt{i,j}(1:break1-1,:);
        sortresult2.vltlt.rslt{i,j}=sortresult.vltlt.rslt{i,j}(break1:hang,:);
    end;
end;
%% last month
break1 = 1192;
for i=1:3
    for j=1:2
        [hang,~]=size(sortresult.lastmon.rslt{i,j});
        sortresult1.lastmon.rslt{i,j}=sortresult.lastmon.rslt{i,j}(1:break1-1,:);
        sortresult2.lastmon.rslt{i,j}=sortresult.lastmon.rslt{i,j}(break1:hang,:);
    end;
end;
%% last six-month
break1 = 1098;
for i=1:3
    for j=1:2
        [hang,~]=size(sortresult.sixmonth.rslt{i,j});
        sortresult1.sixmonth.rslt{i,j}=sortresult.sixmonth.rslt{i,j}(1:break1-1,:);
        sortresult2.sixmonth.rslt{i,j}=sortresult.sixmonth.rslt{i,j}(break1:hang,:);
    end;
end;
%% last sixty-month
%break1 = 856;
for i=1:3
    for j=1:2
        %[hang,~]=size(sortresult1.sixmonth.rslt{i,j});
        %sortresult1.sixmonth.rslt{i,j}=sortresult.sixmonth.rslt{i,j}(1:break1-1,:);
        sortresult1.sixtymonth.rslt{i,j} = [];
        sortresult2.sixtymonth.rslt{i,j}=sortresult.sixmonth.rslt{i,j};
    end;
end;
end

