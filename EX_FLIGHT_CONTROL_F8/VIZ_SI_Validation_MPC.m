
%% Shift input for better readability of figure
uval = 0.7;
u_data = ([u,u_valid(2:end-1),uHistory(1:ct-1)])+uval;

%% Show results
clear ph pt th

xlimval = [0 tHistory(end)];
ylimval = [-2 1];
Jmax = max(cumsum(Results(1).J));

figure;
xlabel(gca,'Time, $t$', 'Interpreter', 'latex')
ylabel(gca,'$x_i$', 'Interpreter', 'latex')
set(gca,'LineWidth',1, 'FontSize',14)
set(gcf,'Position',[100 100 450 200])
set(gcf,'PaperPositionMode','auto')
hold on, box on,
ccolors = get(gca,'colororder');

% Define colors for each model
ModelColors = zeros(3,3,Nmodels);
ModelColors(:,:,1) = [1 0 0; 1 0 0; 1 0 0];
ModelColors(:,:,2) = [0 1 0; 0 1 0; 0 1 0];
ModelColors(:,:,3) = [0.7,0.7,1; 0.7,0.7,1; 0.7,0.7,1];

% Plot vertical lines to distinguish training, validation, control stage
plot([t(end),t(end)],[ylimval],':','Color',[0.4,0.4,0.4],'LineWidth',1)
plot([tA(end),tA(end)],[ylimval],':','Color',[0.4,0.4,0.4],'LineWidth',1)
th(1) = text(5,250,'Training', 'FontSize',12);
th(2) = text(tA(1)+5,250,'Validation', 'FontSize',12);
th(3) = text(tHistory(1)+5,250,'Control', 'FontSize',12);
th(4) = text(tHistory(1)+5,230,'turned on', 'FontSize',12);

if size(t_valid,2)~=1
    t_valid = t_valid';
end

% Show results
plot([t;t_valid(2:end-1);tHistory(2:ct)'],uval.*ones(size([t;t_valid(2:end-1);tHistory(2:ct)'])),'-k','LineWidth',0.5);
ph(4) = plot([t;t_valid(2:end-1);tHistory(2:ct)'],u_data,'-k','LineWidth',1);
ph(1) = plot([t;tA(2:end);tHistory(2:end)'],[x(:,1);xA(2:end,1);xHistory(1,2:end)'],'-','Color',ccolors(1,:),'LineWidth',1);
ph(2) = plot([t;tA(2:end);tHistory(2:end)'],[x(:,2);xA(2:end,2);xHistory(2,2:end)'],'-','Color',ccolors(2,:),'LineWidth',1);
ph(3) = plot([t;tA(2:end);tHistory(2:end)'],[x(:,3);xA(2:end,3);xHistory(3,2:end)'],'-','Color',ccolors(3,:),'LineWidth',1);

% Just a straight line
plot([t;tHistory'],zeros(length([t;tHistory']),1),'-k','LineWidth',0.5)

ax1 = gca;
set(ax1,'xlim',xlimval,'ylim',ylimval,'XColor','k','YColor','k');
legend_handle1 = legend(ph,'x1','x2','x3','Control','Location','NorthWest','location','SouthWest');
legend_handle1.Position = [legend_handle1.Position(1)+0.00 legend_handle1.Position(2)-0.02 legend_handle1.Position(3:4)];
ax2 = axes('Position',get(ax1,'Position'),'xlim',xlimval,'ylim',ylimval,'Visible','off','Color','none');
pt(1) = plot([t;tA(2:end);tHistory(2:end)'],[x(:,1);xA(2:end,1);xHistory(1,2:end)'],'-','Color',ccolors(1,:),'LineWidth',1,'Parent',ax2); 
hold on

% Show prediction over validation stage
switch select_model
    case 'DMDc'
        pt(2) = plot(tB_DMD,xB_DMD(:,1),'-.','Color',ModelColors(1,:,1),'LineWidth',2,'Parent',ax2);
        plot(tB_DMD,xB_DMD(:,2),'-.','Color',ModelColors(2,:,1),'LineWidth',2,'Parent',ax2);
        plot(tB_DMD,xB_DMD(:,3),'-.','Color',ModelColors(3,:,1),'LineWidth',2,'Parent',ax2);
    case 'DelayDMDc'
        pt(2) = plot(tB,xB(:,1),'-.','Color',ModelColors(1,:,1),'LineWidth',2,'Parent',ax2);
        plot(tB,xB(:,2),'-.','Color',ModelColors(2,:,1),'LineWidth',2,'Parent',ax2);
        plot(tB,xB(:,3),'-.','Color',ModelColors(3,:,1),'LineWidth',2,'Parent',ax2);
    case 'SINDYc'
        pt(2) = plot(tB_SINDY,xB_SINDY(:,1),'-.','Color',ModelColors(1,:,2),'LineWidth',2,'Parent',ax2);
        plot(tB_SINDY,xB_SINDY(:,2),'-.','Color',ModelColors(2,:,2),'LineWidth',2,'Parent',ax2);
        plot(tB_SINDY,xB_SINDY(:,3),'-.','Color',ModelColors(3,:,2),'LineWidth',2,'Parent',ax2);
    case 'NARX'
        pt(2) = plot(tA(1:end),xD(:,1),'-.','Color',ModelColors(1,:,3),'LineWidth',2,'Parent',ax2);
        plot(tA(1:end),xD(:,2),'-.','Color',ModelColors(2,:,3),'LineWidth',2,'Parent',ax2);
        plot(tA(1:end),xD(:,3),'-.','Color',ModelColors(3,:,3),'LineWidth',2,'Parent',ax2);
end


set(gca,'xlim',xlimval,'ylim',ylimval,'Visible','off','Color','none')
legend_handle2 = legend(gca,pt,'True',select_model,'location','NorthEast');
legend_handle2.Position = [legend_handle1.Position(1)+0.35 legend_handle1.Position(2)+0.02 legend_handle2.Position(3:4)];
set(legend_handle2, 'Color', 'none');
set(gca,'LineWidth',1, 'FontSize',14)

print('-depsc2', '-painters','-cmyk', '-loose', [figpath,'EX_',SystemModel,'_MPC_',select_model,'_N_',num2str(N),'.eps']);

delete(legend_handle1)
delete(legend_handle2)
delete(th)
print('-depsc2', '-painters', '-cmyk', '-loose', [figpath,'EX_',SystemModel,'_MPC_',select_model,'_clean','_N_',num2str(N),'.eps']);


set(ax1,'xlim',xlimval,'ylim',[ylimval(1),ylimval(2)])
set(ax2,'xlim',xlimval,'ylim',[ylimval(1),ylimval(2)],'Visible','off','Color','none')
set(gca,'xlim',xlimval,'ylim',[ylimval(1),ylimval(2)])
print('-depsc2', '-painters', '-cmyk', '-loose',[figpath,'EX_',SystemModel,'_MPC_',select_model,'_clean_zoom','_N_',num2str(N),'.eps']);


%% Dummy plot for legend // Models
% close all
clear ph
figure; hold on, box on
for jM = 1:Nmodels
    ph(jM) = plot([t;tA(2:end);tHistory(2:end)'],ones(length([t;tA(2:end);tHistory(2:end)']), 1),'-.','Color',ModelColors(2,:,jM),'LineWidth',1);
end
set(gca,'xlim',[0 max(tHistory)],'ylim',[0 2])
legend(ph,ModelCollection,'location','northoutside', 'Orientation', 'horizontal', 'box', 'off')
set(gca,'LineWidth',1, 'FontSize',14)
axis off
set(gcf,'Position',[100 100 450 100])
set(gcf,'PaperPositionMode','auto')
print('-depsc2', '-painters', '-cmyk', '-loose',[figpath,'EX_',SystemModel,'_MPC_',select_model,'_legend','_N_',num2str(N),'.eps']);

%% Dummy plot for legend
% close all
clear ph lh
figure; hold on, box on
ccolors = get(gca,'colororder');
ph(1) = plot([t;tA(2:end);tHistory(2:end)'],ones(length([t;tA(2:end);tHistory(2:end)']), 1),'-','Color',ccolors(1,:),'LineWidth',2);
ph(2) = plot([t;tA(2:end);tHistory(2:end)'],ones(length([t;tA(2:end);tHistory(2:end)']), 1),'-','Color',ccolors(2,:),'LineWidth',2);
ph(3) = plot([t;tA(2:end);tHistory(2:end)'],ones(length([t;tA(2:end);tHistory(2:end)']), 1),'-','Color',ccolors(3,:),'LineWidth',2);
ph(4) = plot([t;tA(2:end);tHistory(2:end)'],ones(length([t;tA(2:end);tHistory(2:end)']), 1),'-','Color','k','LineWidth',2);
set(gca,'xlim',[0 max(tHistory)],'ylim',[0 2])
lh = legend(ph,'x1', 'x2', 'x3', 'Control');
set(lh,'location','northoutside', 'Orientation', 'horizontal', 'box', 'off', 'FontSize',16)
set(gca,'LineWidth',1, 'FontSize',14)
axis off
set(gcf,'Position',[100 100 450 100])
set(gcf,'PaperPositionMode','auto')
print('-depsc2', '-painters', '-cmyk', '-loose',[figpath,'EX_',SystemModel,'_MPC_legend','.eps']);