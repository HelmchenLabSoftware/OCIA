function OCIA_annotateTable_gregor(this)
% OCIA_annotateTable_gregor - [no description]
%
%       OCIA_annotateTable_gregor(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% match ROISets to imaging data
DWMatchROISetsToData(this);

% show the table
DWDisplayTable(this);

end

