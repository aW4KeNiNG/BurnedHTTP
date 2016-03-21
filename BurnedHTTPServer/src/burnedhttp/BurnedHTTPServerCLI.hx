package burnedhttp;

import burnedhttp.classes.*;
#if neko
import neko.vm.Thread;
#elseif cpp
import cpp.vm.Thread;
#elseif cs
import cs.system.threading.*;
#end
import sys.FileSystem;
import sys.io.*;
import sys.net.Host;
import sys.net.Socket;

/**
 * ...
 * @author omnibean
 */
class BurnedHTTPServerCLI 
{
	static var serverVersion:String = "0.2";
	static function main() 
	{
		Sys.println("BurnedHTTPServer v" + serverVersion);
		Sys.println("(c) 2015 - 2016 0xFireball");
		var confFileName = "burnedhttp.json";
		if (!FileSystem.exists(confFileName))
		{
			//The conf file does not exist, generate it with default settings
			GenerateConfigFile(confFileName);
		}
		var configJson = File.getContent(confFileName);
		var serverconfigurations:Array<ServerSettings> = JsonType.decode(configJson);
		//var settings:ServerSettings = new ServerSettings(new Host("0.0.0.0"), 4010, "www", true);
		for (settings in serverconfigurations)
		{
			#if (neko || cpp)
			var server:BurnedHTTPServer = new BurnedHTTPServer(settings);
			Thread.create(server.StartListener);
			#elseif cs
			var server:BurnedHTTPServer = new BurnedHTTPServer(settings);
			new Thread(new ThreadStart(server.StartListener)).Start();
			#end
		}
		Sys.sleep(-1);
	}
	static function GenerateConfigFile(configFileName:String)
	{
		var defaultServerConfig:ServerSettings = new ServerSettings("0.0.0.0", 4010, "www", true);
		var jStr = JsonType.encode([defaultServerConfig]);
		File.saveContent(configFileName, jStr);
	}
}