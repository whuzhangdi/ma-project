function [ mark ] = tubiao_boxplot3( sortresult,para,strategy )
%做出图表，箱体图
%   调用示例：[ para ] = tubiao_boxplot3( sortresult,1,'roc' );
%            [ para ] = tubiao_boxplot2( sortresult,1,'roc' );
%            [ para ] = tubiao_boxplot1( sortresult,1,'roc' );
% 日波动率、日交易量、日持仓量、上月收益、过去六月收益和过去六十月收益
load 'factors.mat';
figure_FontSize=12;
%set(gcf,'Position',[100 100 260 220]);
%set(gca,'Position',[.13 .17 .80 .74]);  %调整 XLABLE和YLABLE不会被切掉
%% sixmonth
para =1;
temp = eval(['sortresult.sixmonth.table.',strategy]);
ma2=temp.info{para,2};% 提取ma策略日收益
ma2_info=temp.info{para,1};
%bah2=sortresult.sixmonth.table.bah.info{para,2};% 提取bah策略日收益
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
[hang,~]=size(ma2_mon);
if hang<144
    ma2_mon=[zeros(144-hang,1);ma2_mon];
end;
ma2_mon=reshape(ma2_mon(1:144,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%将ma2按年分组，并提取为一列，其中取最小年份为对应行数
set(gca,'XTick',2003:1:2014,'position',[.00 .00 1, 1]);
subplot(2,3,1);
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
boxplot(ma2_mon,'labels',{'2003','','2005','','2007','','2009','','2011','','2013',''});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
%title('收益率变化趋势');
%xlabel('过去六月分组L','FontWeight','Bold','FontSize',12);
%ylabel('月收益率','FontWeight','Bold','FontSize',12);
xlabel('past six-month L','FontWeight','Bold','FontSize',12);
ylabel('month return','FontWeight','Bold','FontSize',12);
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;

para =2;
temp = eval(['sortresult.sixmonth.table.',strategy]);
ma2=temp.info{para,2};% 提取ma策略日收益
ma2_info=temp.info{para,1};
%bah2=sortresult.sixmonth.table.bah.info{para,2};% 提取bah策略日收益
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
[hang,~]=size(ma2_mon);
if hang<144
    ma2_mon=[zeros(144-hang,1);ma2_mon];
end;
ma2_mon=reshape(ma2_mon(1:144,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%将ma2按年分组，并提取为一列，其中取最小年份为对应行数
subplot(2,3,2);
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
boxplot(ma2_mon,'labels',{'2003','','2005','','2007','','2009','','2011','','2013',''});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'XTick',2003:1:2014);
%title('收益率变化趋势');
%xlabel('过去六月分组M','FontWeight','Bold','FontSize',12);
xlabel('past six-month M','FontWeight','Bold','FontSize',12);
%ylabel('月收益率');
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;

para =3;
temp = eval(['sortresult.sixmonth.table.',strategy]);
ma2=temp.info{para,2};% 提取ma策略日收益
ma2_info=temp.info{para,1};
%bah2=sortresult.sixmonth.table.bah.info{para,2};% 提取bah策略日收益
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
[hang,~]=size(ma2_mon);
if hang<144
    ma2_mon=[zeros(144-hang,1);ma2_mon];
end;
ma2_mon=reshape(ma2_mon(1:144,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%将ma2按年分组，并提取为一列，其中取最小年份为对应行数
subplot(2,3,3);
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
boxplot(ma2_mon,'labels',{'2003','','2005','','2007','','2009','','2011','','2013',''});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'XTick',2003:1:2014);
%title('收益率变化趋势');
%xlabel('过去六月分组H','FontWeight','Bold','FontSize',12);
xlabel('past six-month H','FontWeight','Bold','FontSize',12);
%ylabel('月收益率');
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;
%% sixtymonth
para =1;
temp = eval(['sortresult.sixtymonth.table.',strategy]);
ma2=temp.info{para,2};% 提取ma策略日收益
ma2_info=temp.info{para,1};
%bah2=sortresult.sixtymonth.table.bah.info{para,2};% 提取bah策略日收益
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
ma2_mon=reshape(ma2_mon(1:84,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%将ma2按年分组，并提取为一列，其中取最小年份为对应行数
subplot(2,3,4);
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);

boxplot(ma2_mon,'labels',{'2008','','2010','','2011','','2014'});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'XTick',2003:1:2014);
%title('收益率变化趋势');
%xlabel('过去六十月分组L','FontWeight','Bold','FontSize',12);
%ylabel('月收益率','FontWeight','Bold','FontSize',12);
xlabel('past sixty-month L','FontWeight','Bold','FontSize',12);
ylabel('month retrun','FontWeight','Bold','FontSize',12);
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;

para =2;
temp = eval(['sortresult.sixtymonth.table.',strategy]);
ma2=temp.info{para,2};% 提取ma策略日收益
ma2_info=temp.info{para,1};
%bah2=sortresult.sixtymonth.table.bah.info{para,2};% 提取bah策略日收益
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
ma2_mon=reshape(ma2_mon(1:84,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%将ma2按年分组，并提取为一列，其中取最小年份为对应行数
subplot(2,3,5);
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);

boxplot(ma2_mon,'labels',{'2008','','2010','','2011','','2014'});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'XTick',2003:1:2014);
%title('收益率变化趋势');
%xlabel('过去六十月分组M','FontWeight','Bold','FontSize',12);
xlabel('past sixty-month M','FontWeight','Bold','FontSize',12);
%ylabel('月收益率');
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;

para =3;
temp = eval(['sortresult.sixtymonth.table.',strategy]);
mark=temp.cum{para,1};% 提取每年的标签
ma2=temp.info{para,2};% 提取ma策略日收益
ma2_info=temp.info{para,1};
%bah2=sortresult.sixtymonth.table.bah.info{para,2};% 提取bah策略日收益
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
ma2_mon=reshape(ma2_mon(1:84,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%将ma2按年分组，并提取为一列，其中取最小年份为对应行数
subplot(2,3,6);
boxplot(ma2_mon,'labels',{'2008','','2010','','2011','','2014'});
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);

%title('收益率变化趋势');
%xlabel('过去六十月分组H','FontWeight','Bold','FontSize',12);
xlabel('past sixty-month H','FontWeight','Bold','FontSize',12);
%ylabel('月收益率');
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;
end

