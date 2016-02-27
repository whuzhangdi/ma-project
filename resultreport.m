function [yes] = resultreport(sortresult,filename,sheetname)
%将策略结果输出到电子表格中
%   [yes] = resultreport(result,'ma_result.xls','roc');
%filename = 'ma_result.xls';
temp = eval(['sortresult.vlm.table.',sheetname]);
xlswrite(filename,temp.table,sheetname,'J8');
xlswrite(filename,sortresult.vlm.table.bah.table,sheetname,'B8');
temp = eval(['sortresult.openinst.table.',sheetname]);
xlswrite(filename,temp.table,sheetname,'J12');
xlswrite(filename,sortresult.openinst.table.bah.table,sheetname,'B12');
temp = eval(['sortresult.vltlt.table.',sheetname]);
xlswrite(filename,temp.table,sheetname,'J4');
xlswrite(filename,sortresult.vltlt.table.bah.table,sheetname,'B4');
temp = eval(['sortresult.lastmon.table.',sheetname]);
xlswrite(filename,temp.table,sheetname,'J16');
xlswrite(filename,sortresult.lastmon.table.bah.table,sheetname,'B16');
temp = eval(['sortresult.sixmonth.table.',sheetname]);
xlswrite(filename,temp.table,sheetname,'J20');
xlswrite(filename,sortresult.sixmonth.table.bah.table,sheetname,'B20');
temp = eval(['sortresult.sixtymonth.table.',sheetname]);
xlswrite(filename,temp.table,sheetname,'J24');
xlswrite(filename,sortresult.sixtymonth.table.bah.table,sheetname,'B24');
xlswrite(filename,now-693960,sheetname,'A29');
%% 
disp(sheetname);
disp('complete!');
yes=1;
end

