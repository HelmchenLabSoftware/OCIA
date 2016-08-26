function s = initBehaviorBoxController()


    s = serial('COM8');
    set(s, 'BaudRate', 115000, 'DataBits', 8, 'StopBits', 1, 'Parity', 'none');
    fopen(s);
    
    fprintf(s, '%s', [char(27) '\r']);
    out = fscanf(s)
    
    fprintf(s, '%s', 'C0o\r');
    
    fprintf(s, '%s', [char(27) '\r']);
    out = fscanf(s)
    
    daqreset;
    valveControl = daq.createSession('ni');
    valveControl.addDigitalChannel('BehaviorBox', 'Port0/Line0', 'OutputOnly');
    valveControl.outputSingleScan(0);
    
    fclose(s);
    delete(s);
    clear('s');

end

