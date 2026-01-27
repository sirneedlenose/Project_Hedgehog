package;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class PlayState extends FlxState
{
	private var sonic:Sonic;
	private var debugDisplay:DebugDisplay;

	private var playerState:String;

	public override function create():Void
	{
		sonic = new Sonic(100, 100);
		sonic.screenCenter();
		add(sonic);

		debugDisplay = new DebugDisplay();
		add(debugDisplay);
	}

	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if(Controls.TAB)
		{
			displayDebugInfo();
		}

		// Update debug display with Sonic's current state
		// Update only if the state has changed
		if(sonic.playerStateToString() != playerState || playerState == null){
			playerState = sonic.playerStateToString();
			debugDisplay.updatePlayerState(playerState);
		}
	}

	public function displayDebugInfo():Void
	{
		debugDisplay.visible = !debugDisplay.visible;
	}
}
