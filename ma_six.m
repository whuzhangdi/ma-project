function [dataset] = ma_six(dataset,para,rf)
%ma_six run BAH ROC WMA EMA MACD VMA K&D S&R OBV on bootstrap-generated
%data set
%  example: [bootstrap_result{j,1}] = ma_six(new_dataset,{fma,sam,year,short},rf);
[ dataset.vlm.table ] = strategydemo_tech( dataset.vlm.rslt,para,rf );
[ dataset.openinst.table ] = strategydemo_tech( dataset.openinst.rslt,para,rf );
[ dataset.vltlt.table ] = strategydemo_tech( dataset.vltlt.rslt,para,rf );
[ dataset.lastmon.table ] = strategydemo_tech( dataset.lastmon.rslt,para,rf );
[ dataset.sixmonth.table ] = strategydemo_tech( dataset.sixmonth.rslt,para,rf );
[ dataset.sixtymonth.table ] = strategydemo_tech( dataset.sixtymonth.rslt,para,rf );
end

