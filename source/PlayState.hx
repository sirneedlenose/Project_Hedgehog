package;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.util.FlxSpriteUtil;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class PlayState extends FlxState
{
	private var cameraTarget:FlxSprite;
	private var debugCamera:FlxCamera;
	public var sonic:Sonic;
	private var debugDisplay:DebugDisplay;
	public var act:Act;

	private var playerState:String;

	public override function create():Void
	{
		
		bgColor = FlxColor.GRAY;

		cameraTarget = new FlxSprite(0, 0);
		cameraTarget.makeGraphic(20,20,FlxColor.RED);
		add(cameraTarget);

		FlxG.camera.follow(cameraTarget);

		debugDisplay = new DebugDisplay();
		//add(debugDisplay);

		act = new Act("assets/data/act.tmx", this); // Pass the PlayState reference here
		add(act.foregroundGroup);
		add(act.objectGroup);
		
		//add(sonic);

		var playerPoint:FlxSprite = new FlxSprite(sonic.x, sonic.y);
		playerPoint.makeGraphic(10,10, FlxColor.GREEN);
		add(playerPoint); // Debug point to show player's position
	}

	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if(Controls.TAB)
		{
			//displayDebugInfo();
		}

		if(Controls.LEFT)
		{
			cameraTarget.x -= 20;

		}

		if(Controls.RIGHT)
		{
			cameraTarget.x += 20;

		}

		if(Controls.UP)
		{
			cameraTarget.y -= 20;

		}
		if(Controls.DOWN)
		{
			cameraTarget.y += 20;

		}
		if(Controls.ACTION_1)
		{
			trace("Camera Target Position: (" + cameraTarget.x + ", " + cameraTarget.y + ")");

		}
	}
}
