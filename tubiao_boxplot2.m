function [ mark ] = tubiao_boxplot2( sortresult,para,strategy )
%����ͼ������ͼ
%   ����ʾ����[ para ] = tubiao_boxplot3( sortresult,1 );
%            [ para ] = tubiao_boxplot2( sortresult,1 );
%            [ para ] = tubiao_boxplot1( sortresult,1 );
load 'factors.mat';
figure_FontSize=12;
%set(gcf,'Position',[100 100 260 220]);
%set(gca,'Position',[.13 .17 .80 .74]);  %���� XLABLE��YLABLE���ᱻ�е�
%% vltlt
para =1;
temp = eval(['sortresult.vltlt.table.',strategy]);
ma2=temp.info{para,2};% ��ȡma����������
ma2_info=temp.info{para,1};
%bah2=sortresult.vltlt.table.bah.info{para,2};% ��ȡbah����������
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
ma2_mon=reshape(ma2_mon(1:144,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%��ma2������飬����ȡΪһ�У�����ȡ��С���Ϊ��Ӧ����
subplot(2,3,1);
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
boxplot(ma2_mon,'labels',{'2003','','2005','','2007','','2009','','2011','','2013',''});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'XTick',2003:1:2014);
%title('�����ʱ仯����');
%xlabel('�����ʷ���L','FontWeight','Bold','FontSize',12);
%ylabel('��������','FontWeight','Bold','FontSize',12);
xlabel('volatility L','FontWeight','Bold','FontSize',12);
ylabel('month return','FontWeight','Bold','FontSize',12);
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;

para =2;
temp = eval(['sortresult.vltlt.table.',strategy]);
ma2=temp.info{para,2};% ��ȡma����������
ma2_info=temp.info{para,1};
%bah2=sortresult.vltlt.table.bah.info{para,2};% ��ȡbah����������
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
ma2_mon=reshape(ma2_mon(1:144,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%��ma2������飬����ȡΪһ�У�����ȡ��С���Ϊ��Ӧ����
subplot(2,3,2);
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
boxplot(ma2_mon,'labels',{'2003','','2005','','2007','','2009','','2011','','2013',''});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'XTick',2003:1:2014);
%title('�����ʱ仯����');
%xlabel('�����ʷ���M','FontWeight','Bold','FontSize',12);
xlabel('volatility M','FontWeight','Bold','FontSize',12);
%ylabel('��������');
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;

para =3;
temp = eval(['sortresult.vltlt.table.',strategy]);
ma2=temp.info{para,2};% ��ȡma����������
ma2_info=temp.info{para,1};
%bah2=sortresult.vltlt.table.bah.info{para,2};% ��ȡbah����������
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
ma2_mon=reshape(ma2_mon(1:144,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%��ma2������飬����ȡΪһ�У�����ȡ��С���Ϊ��Ӧ����
subplot(2,3,3);
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
boxplot(ma2_mon,'labels',{'2003','','2005','','2007','','2009','','2011','','2013',''});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'XTick',2003:1:2014);
%title('�����ʱ仯����');
%xlabel('�����ʷ���H','FontWeight','Bold','FontSize',12);
xlabel('volatility H','FontWeight','Bold','FontSize',12);
%ylabel('��������');
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;

%% lastmon
para =1;
temp = eval(['sortresult.lastmon.table.',strategy]);
ma2=temp.info{para,2};% ��ȡma����������
ma2_info=temp.info{para,1};
%bah2=sortresult.lastmon.table.bah.info{para,2};% ��ȡbah����������
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
[hang,~]=size(ma2_mon);
if hang<144
    ma2_mon=[zeros(144-hang,1);ma2_mon];
end;
ma2_mon=reshape(ma2_mon(1:144,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%��ma2������飬����ȡΪһ�У�����ȡ��С���Ϊ��Ӧ����
subplot(2,3,4);
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
boxplot(ma2_mon,'labels',{'2003','','2005','','2007','','2009','','2011','','2013',''});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'XTick',2003:1:2014);
%title('�����ʱ仯����');
%xlabel('�����������L','FontWeight','Bold','FontSize',12);
%ylabel('��������','FontWeight','Bold','FontSize',12);
xlabel('last month L','FontWeight','Bold','FontSize',12);
ylabel('month return','FontWeight','Bold','FontSize',12);
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;

para =2;
temp = eval(['sortresult.lastmon.table.',strategy]);
ma2=temp.info{para,2};% ��ȡma����������
ma2_info=temp.info{para,1};
%bah2=sortresult.lastmon.table.bah.info{para,2};% ��ȡbah����������
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
[hang,~]=size(ma2_mon);
if hang<144
    ma2_mon=[zeros(144-hang,1);ma2_mon];
end;
ma2_mon=reshape(ma2_mon(1:144,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%��ma2������飬����ȡΪһ�У�����ȡ��С���Ϊ��Ӧ����
subplot(2,3,5);
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
boxplot(ma2_mon,'labels',{'2003','','2005','','2007','','2009','','2011','','2013',''});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'XTick',2003:1:2014);
%title('�����ʱ仯����');
%xlabel('�����������M','FontWeight','Bold','FontSize',12);
xlabel('last month M','FontWeight','Bold','FontSize',12);
%ylabel('��������');
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;

para =3;
temp = eval(['sortresult.lastmon.table.',strategy]);
mark=temp.cum{para,1};% ��ȡÿ��ı�ǩ
ma2=temp.info{para,2};% ��ȡma����������
ma2_info=temp.info{para,1};
%bah2=sortresult.lastmon.table.bah.info{para,2};% ��ȡbah����������
[~,ma2_mon,~] = pfmanalysis( ma2_info,ma2, rf );
[hang,~]=size(ma2_mon);
if hang<144
    ma2_mon=[zeros(144-hang,1);ma2_mon];
end;
ma2_mon=reshape(ma2_mon(1:144,:),12,[]);
%[ma2_adj]=selectbyyear(ma2,mark);%��ma2������飬����ȡΪһ�У�����ȡ��С���Ϊ��Ӧ����
subplot(2,3,6);
boxplot(ma2_mon,'labels',{'2003','','2005','','2007','','2009','','2011','','2013',''});
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
%set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);

set(gca,'XTick',2003:1:2014);
%title('�����ʱ仯����');
%xlabel('�����������H','FontWeight','Bold','FontSize',12);
xlabel('last month H','FontWeight','Bold','FontSize',12);
%ylabel('��������');
ma1=temp.cum{para,2};  %%
hold on;
plot(ma1/12,'k-*'); set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;
end

