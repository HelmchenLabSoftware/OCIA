cd D:\intrinsic\20160104
load 20160104d
cd D:\intrinsic\20160104\d\Matt_files


cond='Texture 1 P100';
dec='Go';

ii=0;
for i=1:size(trials,1)
    if isequal(trials(i,1).stimulus,cond)
        if isequal(trials(i,1).decision,dec)
            if isequal(trials(i,1).report,'Report')
                ii=ii+1;
                if ii==1
                    tr_100=trials(i,1).id;
                else
                    tr_100=[tr_100 trials(i,1).id];
                end
            end
        end
    end
end


cond='Texture 5 P1200';
dec='Go';

ii=0;
for i=1:size(trials,1)
    if isequal(trials(i,1).stimulus,cond)
        if isequal(trials(i,1).decision,dec)
            if isequal(trials(i,1).report,'Report')
                ii=ii+1;
                if ii==1
                    tr_1200=trials(i,1).id;
                else
                    tr_1200=[tr_1200 trials(i,1).id];
                end
            end
        end
    end
end        


% cond='Texture 3 P000';
% dec='No Go';
% 
% ii=0;
% for i=1:size(trials,1)
%     if isequal(trials(i,1).stimulus,cond)
%         if isequal(trials(i,1).decision,dec)
%             if isequal(trials(i,1).report,'Report')
%                 ii=ii+1;
%                 if ii==1
%                     tr_000=trials(i,1).id;
%                 else
%                     tr_000=[tr_000 trials(i,1).id];
%                 end
%             end
%         end
%     end
% end

save trials_ind tr_100 tr_1200 %tr_000




