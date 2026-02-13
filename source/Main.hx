package;
import tests.*;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		#if PLAYERDEBUG
			trace("Player debug mode enabled");
			addChild(new FlxGame(0, 0, PlayerTestState,60,60,true));
		#else
			addChild(new FlxGame(0, 0, PlayState,60,60,true));
		#end
	}
}
