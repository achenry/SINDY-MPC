 
%% Show results for system identification [training, validation]

clear ph
figure,box on, hold on, 
ccolors = get(gca,'colororder');

plot([tA(1),tA(1)],[min(xB(:)) max([xA(:);xB(:)])],':','Color',[0.4,0.4,0.4],'LineWidth',1.5) % plot division between training and validation phases

plot(t,x(:,1),'Color',ccolors(1,:),'LineWidth',1); % plot training data state 1
plot(t,x(:,2),'Color',ccolors(2,:),'LineWidth',1); % plot training data state 2
plot(t,x(:,3),'Color',ccolors(3,:),'LineWidth',1); % plot training data state 3

ph(1) = plot([t;tA],[x(:,1);xA(:,1)],'Color',ccolors(1,:),'LineWidth',1); % plot training data and validation data state 1
ph(2) = plot([t;tA],[x(:,2);xA(:,2)],'Color',ccolors(2,:),'LineWidth',1); % plot training data and validation data state 2
ph(3) = plot([t;tA],[x(:,3);xA(:,3)],'Color',ccolors(3,:),'LineWidth',1); % plot training data and validation data state 3

ph(4) = plot(tB,xB(:,1),'-.','Color',ccolors(1,:)-[0 0.2 0.2],'LineWidth',2); % plot predicted data over validation phase state 1
ph(5) = plot(tB,xB(:,2),'-.','Color',ccolors(2,:)-[0.1 0.2 0.09],'LineWidth',2); % plot predicted data over validation phase state 2
ph(6) = plot(tB,xB(:,3),'-.','Color',ccolors(3,:)-[0.1 0.2 0.09],'LineWidth',2); % plot predicted data over validation phase state 3

grid off
xlim([0 tB(end)])
ylim([min(xB(:)) max([xA(:);xB(:)])])
xlabel('Time, $t$', 'Interpreter', 'latex')
ylabel('States, $x_i(t)$', 'Interpreter', 'latex')
t1 = text(tA(1)-5,40,'Training', 'FontSize',12);
t2 = text(1+tA(1),40,'Validation', 'FontSize',12);
lh = legend(ph([1,4]),'True',ModelName);
lh.Position = [lh.Position(1)-0.5,lh.Position(2)-0.15,lh.Position(3:4)];
set(gca,'LineWidth',1, 'FontSize',14)
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
print('-depsc2', '-loose','-cmyk', [figpath,'EX_',SystemModel,'_SI_',ModelName,'_',InputSignalType,'_Validation_OneFig.eps']);
title('Training Data (left), Validation and Predicted Data (right) of State Trajectory')

delete(lh); delete(t1), delete(t2);
print('-depsc2', '-loose','-cmyk', [figpath,'EX_',SystemModel,'_SI_',ModelName,'_',InputSignalType,'_Validation_OneFig_noleg.eps']);

%% Actuation signal
clear ph
figure,box on, hold on, 
ccolors = get(gca,'colororder');

plot([tA(1),tA(1)],[-15 260],':','Color',[0.4,0.4,0.4],'LineWidth',1.5) % plot division between training and validation phases
plot(t, u,'-k','LineWidth',1); % plot training control input
plot(tv, uv,'-k','LineWidth',1); % plot validation control input

grid off
ylim([min([u uv])+0.05*min([u uv]) max([u uv])+0.05*max([u uv])])
xlim([0 tB(end)])
ylabel('Input')
xlabel('Time, $t$', 'Interpreter', 'latex')
ylabel('Control Input, $u(t)$', 'Interpreter', 'latex')
set(gca,'LineWidth',1, 'FontSize',14)
set(gcf,'Position',[100 100 300 200])
set(gcf,'PaperPositionMode','auto')
print('-depsc2', '-loose','-cmyk', [figpath,'EX_',SystemModel,'_SI_',ModelName,'_',InputSignalType,'_Actuation_OneFig.eps']);
title('Training Data (left), Validation Data (right) of Control Input Signal')