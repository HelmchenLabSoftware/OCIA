function sendGmail(recipient,subj,body,pw)
% this function requires that Internet preference settings are available,
% except password, which can be provided and is blanked again afterwards

try
    if isempty(pw)
        pw = passwordEntryDialog('CheckPasswordLength',false);
    end
    
    myaddress = 'hluetck@gmail.com';
    setpref('Internet','E_mail',myaddress);
    setpref('Internet','SMTP_Server','smtp.gmail.com');
    setpref('Internet','SMTP_Username',myaddress);
    setpref('Internet','SMTP_Password',pw);
    
    props = java.lang.System.getProperties;
    props.setProperty('mail.smtp.auth','true');
    props.setProperty('mail.smtp.socketFactory.class', ...
        'javax.net.ssl.SSLSocketFactory');
    props.setProperty('mail.smtp.socketFactory.port','465');
    
    sendmail(recipient,subj,body);
    
    setpref('Internet','SMTP_Password','');
    
    clear all
catch
    
    % clean up
    setpref('Internet','SMTP_Password','');
    clear all
    
    rethrow(lasterror)
    
end