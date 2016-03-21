package burnedhttp.classes;
import sys.net.Host;

/**
 * ...
 * @author omnibean
 */
class ServerSettings
{
	public var ServerHost:String;
	public var ServerPort:Int;
	public var DocumentRoot:String;
	public var EnableLogging:Bool;
	public function new(serverHost:String, serverPort:Int, docRoot:String, enableLogging:Bool)
	{
		this.ServerHost = serverHost;
		this.ServerPort = serverPort;
		this.DocumentRoot = docRoot;
		this.EnableLogging = enableLogging;
	}
	
}