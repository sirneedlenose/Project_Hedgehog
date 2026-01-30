package;

import flixel.FlxCamera;
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
	private var sonic:Sonic;
	private var debugDisplay:DebugDisplay;
	private var act:Act;

	private var playerState:String;

	public override function create():Void
	{
		
		bgColor = FlxColor.GRAY;

		cameraTarget = new FlxSprite(0, 0);
		cameraTarget.makeGraphic(1,1,FlxColor.TRANSPARENT);

		FlxG.camera.follow(cameraTarget);

		debugDisplay = new DebugDisplay();
		//add(debugDisplay);

		act = new Act("assets/data/testTileMap.tmx", this); // Pass the PlayState reference here
		add(act.objectLayer);
		add(act.tileLayer);
		add(sonic);
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

		FlxG.collide(sonic, act.tileLayer);
	}


	public function setPlayer(player:Sonic):Void
	{
		this.sonic = player;
		
	}
}
