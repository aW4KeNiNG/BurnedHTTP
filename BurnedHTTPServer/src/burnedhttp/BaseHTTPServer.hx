package burnedhttp;
import burnedhttp.classes.Logger;
import burnedhttp.classes.ServerSettings;
import sys.net.Host;
import sys.net.Socket;
#if neko
import neko.vm.Thread;
#elseif cpp
import cpp.vm.Thread;
#end

/**
 * ...
 * @author omnibean
 */
class BaseHTTPServer
{

	var _serverSettings:ServerSettings;
	var _hostAddress:String;
	var _host:Host;
	var _port:Int;
	var _wwwroot:String;
	var listener:Socket;
	
	public function new(serverSettings:ServerSettings)
	{
		_serverSettings = serverSettings;
		_hostAddress = _serverSettings.ServerHost;
		_host = new Host(_serverSettings.ServerHost);
		_port = _serverSettings.ServerPort;
		_wwwroot = _serverSettings.DocumentRoot;
		Logger.enableLogging = _serverSettings.EnableLogging;
	}
	
	public function StartListener()
	{
		listener = new Socket();
		listener.bind(_host, _port);
		listener.listen(5);
		while (true)
		{			
			var client:Socket = listener.accept();
			var processRequest = new HTTPResponse(client, this).Process;
			#if neko
			var rThread:Thread = Thread.create(processRequest); //Spawn a new thread to process the request
			#else
			processRequest();
			#end
		}
	}
	
	public function HandleGETRequest(response:HTTPResponse)
	{
		
	}
	
	public function HandlePOSTRequest(response:HTTPResponse)
	{
		
	}
	
}