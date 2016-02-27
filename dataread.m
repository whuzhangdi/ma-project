function [ data_allall, data_txtall, dataall] = dataread(  )
% read futures data form 2003 to 2014, total 12 years
% example: [ data_allall, data_txtall,dataall] = dataread(  );
%% file 
[data,data_txt,data_all]=xlsread('D:\program files\matlab\bin\maproject_english\FUT_Fdt.xls','FUT_Fdt');
data_txt=data_txt(4:65003,:);
data_all=data_all(4:65003,:);
date=datevec(data(:,4));
data=[date(:,1:3),data];
%% file 1
[dataone,data_txtone,data_allone]=xlsread('D:\program files\matlab\bin\maproject_english\FUT_Fdt1.xls','FUT_Fdt1');
data_txtone=data_txtone(4:65002,:);
data_allone=data_allone(4:65002,:);
dateone=datevec(dataone(:,4));
dataone=[dateone(:,1:3),dataone];
%% file 2
[datatwo,data_txttwo,data_alltwo]=xlsread('D:\program files\matlab\bin\maproject_english\FUT_Fdt2.xls','FUT_Fdt2');
data_txttwo=data_txttwo(4:65002,:);
data_alltwo=data_alltwo(4:65002,:);
datetwo=datevec(datatwo(:,4));
datatwo=[datetwo(:,1:3),datatwo];
%% file 3
[datathree,data_txtthree,data_allthree]=xlsread('D:\program files\matlab\bin\maproject_english\FUT_Fdt3.xls','FUT_Fdt3');
data_txtthree=data_txtthree(4:65002,:);
data_allthree=data_allthree(4:65002,:);
datethree=datevec(datathree(:,4));
datathree=[datethree(:,1:3),datathree];
%% file 4
[datafour,data_txtfour,data_allfour]=xlsread('D:\program files\matlab\bin\maproject_english\FUT_Fdt4.xls','FUT_Fdt4');
data_txtfour=data_txtfour(4:40006,:);
data_allfour=data_allfour(4:40006,:);
datefour=datevec(datafour(:,4));
datafour=[datefour(:,1:3),datafour];
%% file 5
[datafive,data_txtfive,data_allfive]=xlsread('D:\program files\matlab\bin\maproject_english\FUT_Fdt5.xls','FUT_Fdt5');
data_txtfive=data_txtfive(4:65003,:);
data_allfive=data_allfive(4:65003,:);
datefive=datevec(datafive(:,4));
datafive=[datefive(:,1:3),datafive];
%% file 6
[datasix,data_txtsix,data_allsix]=xlsread('D:\program files\matlab\bin\maproject_english\FUT_Fdt6.xls','FUT_Fdt6');
data_txtsix=data_txtsix(4:65002,:);
data_allsix=data_allsix(4:65002,:);
datesix=datevec(datasix(:,4));
datasix=[datesix(:,1:3),datasix];
%% file 7
[dataseven,data_txtseven,data_allseven]=xlsread('D:\program files\matlab\bin\maproject_english\FUT_Fdt7.xls','FUT_Fdt7');
data_txtseven=data_txtseven(4:65002,:);
data_allseven=data_allseven(4:65002,:);
dateseven=datevec(dataseven(:,4));
dataseven=[dateseven(:,1:3),dataseven];
%% file 8
[dataeight,data_txteight,data_alleight]=xlsread('D:\program files\matlab\bin\maproject_english\FUT_Fdt8.xls','FUT_Fdt8');
data_txteight=data_txteight(4:63984,:);
data_alleight=data_alleight(4:63984,:);
dateeight=datevec(dataeight(:,4));
dataeight=[dateeight(:,1:3),dataeight];
%% cat
data_allall=[data_all;data_allone;data_alltwo;data_allthree;data_allfour;data_allfive;data_allsix;data_allseven;data_alleight];
data_txtall=[data_txt;data_txtone;data_txttwo;data_txtthree;data_txtfour;data_txtfive;data_txtsix;data_txtseven;data_txteight];
dataall=[data;dataone;datatwo;datathree;datafour;datafive;datasix;dataseven;dataeight];
end

