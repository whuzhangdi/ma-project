function [yes] = alphawrite(alpha,rsquare,pvalue,bta,p_bta, para)
% outport the regression result into xls
%   [yes] = alphawrite(alpha,rsquare,pvalue,2);
% para 2/3:capm/ff
alpha = reshape(alpha,18,9);
pvalue = reshape(pvalue,18,9);
rsquare = reshape(rsquare,18,9);
bta = reshape(bta,18,9);
p_bta = reshape(p_bta,18,9);
if para==2
    xlswrite('alpha.xls',alpha*12,'capm_a','C2');
    xlswrite('alpha.xls',rsquare,'capm_r','C2');
    xlswrite('alpha.xls',pvalue,'capm_p','C2');
    xlswrite('alpha.xls',bta,'capm_beta','C2');
    xlswrite('alpha.xls',p_bta,'capm_beta_p','C2');
    xlswrite('alpha.xls',now-693960,'capm_a','A20');
else
    xlswrite('alpha.xls',alpha*12,'ff_a','C2');
    xlswrite('alpha.xls',rsquare,'ff_r','C2');
    xlswrite('alpha.xls',pvalue,'ff_p','C2');
    xlswrite('alpha.xls',bta,'capm_beta','C2');
    xlswrite('alpha.xls',p_bta,'capm_beta_p','C2');
    xlswrite('alpha.xls',now-693960,'ff_a','A20');
end;

disp('completed!');
yes=1;
end

