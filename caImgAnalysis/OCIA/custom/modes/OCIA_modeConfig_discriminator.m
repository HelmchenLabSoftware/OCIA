function this = OCIA_modeConfig_discriminator(this)
% adds the behavior mode to the OCIA

%% -- properties: path: Discrimnator
% path where the behavior data should be saved
this.path.discrDataSave = 'C:/Users/laurenczy/Documents/Discriminator/';

%% -- properties: GUI: Discrimnator
this.GUI.di = struct();
% update rate of the GUI elements in second
this.GUI.di.updateRate = 0.05;
% handle for the GUI updating timer object
this.GUI.di.updateTimer = [];
% handle for the camera grabber
this.GUI.di.camHandle = [];
% defines whether the activity map is running or not
this.GUI.di.activityRunning = false;
% defines the zoom level for the activity map
this.GUI.di.zoomLevel = 1;
% activity movies
this.GUI.di.actiMovies = {};
% activity movie's current frame
this.GUI.di.actiMovieFrame = 1;
% current activity movie
this.GUI.di.actiMovieIndex = 1;
% defines whether to lock the mouse to a specific coordinate or not
this.di.lockMouse = false;
% defines which coordinates to lock the mouse
this.di.lockCoords = [];

%% - properties: Discrimnator
this.di = struct();
% current index of trial, incremented every new trial
this.di.iTrial = 0;
% current index of stimulus matrix
this.di.iStimMat = randi(10);
% defines whether the current phase is to get a response
this.di.waitingForResp = false;
% time since the starting of the waiting period for the decision
this.di.waitingStartTime = nowUNIX;
% time allowed to take a decision and report reponse
this.di.waitingTime = 8000;
% defines wehther a response was given or not
this.di.resp = false;
% number of responses in the current response time bin
this.di.nResps = 0;
% decay factor for responses
this.di.nRespsDecay = 0.1;
% threshold for the response rate in Hz
this.di.respRateThresh = 5;

% stimulus matrix
this.di.stimMatrix = [
    1,2,1,2,1,2,2,1,1,2;
    1,1,2,1,2,2,1,1,2,2;
    1,1,2,2,1,2,1,1,2,2;
    1,2,1,2,2,1,1,2,2,1;
    1,1,2,1,2,1,2,2,1,2;
    1,2,2,1,1,2,1,2,2,1;
    1,2,2,1,2,1,1,2,2,1;
    1,2,1,1,2,1,2,2,1,2;
    1,2,2,1,1,2,1,2,2,1;
    1,1,2,1,2,1,2,2,1,2;
];
% defines which stimulus is the target stimulus
this.di.targetStim = 1;

   


end
