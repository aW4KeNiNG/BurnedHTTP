package burnedhttp.classes;

/**
 * ...
 * @author ...
 */
class Logger
{
	public static var enableLogging:Bool = true;
	public static function WriteLine(text:String)
	{
		if (enableLogging)
			Sys.println(text);
	}
}