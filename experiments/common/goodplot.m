function goodplot()
% function which produces a nice-looking plot
% and sets up the page for nice printing

%set(findall(gcf,'type','axes'),'fontsize',14,'FontWeight', 'Bold', 'FontName', 'Calibri')
set(get(gca,'title'),'FontSize', 18, 'FontWeight', 'Bold', 'FontName', 'Calibri');
set(get(gca,'xlabel'),'FontSize', 16, 'FontWeight', 'Bold','FontName', 'Calibri');
set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'Bold','FontName', 'Calibri');
set(get(gca,'zlabel'),'FontSize', 16, 'FontWeight', 'Bold','FontName', 'Calibri');

% set(get(gca,'xlabel'),'FontSize', 16, 'FontWeight', 'Bold');
% set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'Bold');
% set(get(gca,'zlabel'),'FontSize', 16, 'FontWeight', 'Bold');
% set(get(gca,'title'),'FontSize', 18, 'FontWeight', 'Bold');
%colorbar;
% box off; axis square;
set(gca,'linewidth',2);
set(gca,'FontSize',14);
set(gca,'FontWeight','Bold');
set(gca,'FontName','Calibri');
set(gcf,'color','w');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize', [12 12]);
set(gcf,'PaperPosition',[0.5 0.5 7 7]);
set(gcf,'PaperPositionMode','Manual');
end
