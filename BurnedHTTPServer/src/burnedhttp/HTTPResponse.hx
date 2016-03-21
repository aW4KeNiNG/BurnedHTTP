package burnedhttp;
import haxe.ds.HashMap;
import haxe.io.Error;
import sys.net.Socket;
import burnedhttp.classes.Logger;

/**
 * ...
 * @author omnibean
 */
class HTTPResponse
{
	
	public var remoteClient:Socket;
	public var HttpHeaders:Map<String, String>;
	
	var httpMethod:String;
	public var requestPath:String;
	var http_protocol_version:String;
	var _baseServer:BaseHTTPServer;
	
	
	public function new(client:Socket, srv:BaseHTTPServer) 
	{
		remoteClient = client;
		_baseServer = srv;
	}
	
	public function sendHeader(header:String)
	{
		remoteClient.output.writeString(header+"\n");
	}
	
	public function sendEndHeaders()
	{
		remoteClient.output.writeString("Connection: close\n");
		remoteClient.output.writeString("\n");
	}
	
	public function writeOutputStream(data:String)
	{
		remoteClient.output.writeString(data);
	}
	
	//{ Errors
	public function sendError404()
	{
		sendHeader("HTTP/1.1 404 File not found");
		sendEndHeaders();
		writeOutputStream("404 - File not found.");
	}
	//}
	
	public function Process()
	{
		parseRequest();
		readHeaders();
		if (httpMethod == "GET")
		{
			_baseServer.HandleGETRequest(this);
		}
		if (httpMethod == "POST")
		{
			_baseServer.HandlePOSTRequest(this);
		}
		remoteClient.output.flush();
		remoteClient.output.close();
	}
	
	//{ Internal Logic
	private function parseRequest()
	{
		var requestLine:String = remoteClient.input.readLine();
		var tokens:Array<String> = requestLine.split(' ');
		if (tokens.length != 3)
		{
			throw "Invalid request";
		}
		httpMethod = tokens[0].toUpperCase();
		requestPath = tokens[1];
		http_protocol_version = tokens[2];
		Logger.WriteLine('[Starting] '+ requestLine);
	}
	private function readHeaders()
	{
		Logger.WriteLine("readHeaders()");
		var line:String;
		HttpHeaders = new Map<String, String>();
		while ((line = remoteClient.input.readLine()) != null)
		{
			if (line=="")
			{
				Logger.WriteLine("got headers");
				return;
			}

			var separator:Int = line.indexOf(':');
			if (separator == -1)
			{
				throw "invalid http header line: " + line;
			}
			var name:String = line.substring(0, separator);
			var pos:Int = separator + 1;
			while ((pos < line.length) && (line.charAt(pos) == ' '))
			{
				pos++; // strip any spaces
			}

			var value:String = line.substring(pos, line.length);
			Logger.WriteLine("header: "+name+":"+value);
			HttpHeaders[name] = value;
		}
	}
	//}
	
}