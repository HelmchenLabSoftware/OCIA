function serverSocketSendMessage(message, outputPort, nRetries, pauseSleepTime)

% imports
import java.net.ServerSocket
import java.io.*

% init
retry = 0;
server_socket  = [];
output_socket  = [];

% loop forever
while true;

    % increment try counter
    retry = retry + 1;

    try
        if (nRetries > 0) && (retry > nRetries); break; end

        % create server socket
        server_socket = ServerSocket(outputPort);
        server_socket.setSoTimeout(2000);

        % accept connections from clients
        output_socket = server_socket.accept;

        % open stream
        output_stream = output_socket.getOutputStream;
        d_output_stream = DataOutputStream(output_stream);

        % write message
        d_output_stream.writeBytes(char(message));
        d_output_stream.flush;

        % clean up
        server_socket.close;
        output_socket.close;
        break;

    catch err; %#ok<NASGU>

        % clean up
        if ~isempty(server_socket); server_socket.close; end
        if ~isempty(output_socket); output_socket.close; end

        % pause before retrying
        pause(pauseSleepTime);
    end
end

end