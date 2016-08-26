figure
clf
set(gcf,'position',[10 50 200 35])
set(gcf,'doublebuffer','on')
set(gcf, 'closerequestfcn','stop(t);delete(t);delete(gcf)');
set(gcf, 'menubar','none')

axes('position',[0 0 1 1 ]);

%Build Timer object and turn on timer
%delay for 1/2 second so rest of setup finishes
t = timer('period',0.1);
set(t,'ExecutionMode','fixedrate','StartDelay',0.5);
set(t,'timerfcn',['cla;',...
                  'ct = datestr(clock,''mmm.dd,yyyy HH:MM:SS:FFF'');',....
                  'text(.05,.5,ct,''fontsize'',12);']);
start(t);