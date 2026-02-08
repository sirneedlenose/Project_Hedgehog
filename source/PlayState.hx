package;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	private var cameraTarget:FlxSprite;
	private var debugCamera:FlxCamera;

	private var playerCam:PlayerCam;

	public var sonic:Sonic;
	public var act:Act;

	public var deathZone:FlxObject;
	private var debugDisplay:DebugDisplay;

	private var playerState:String;

	private var tilemap:FlxTilemap;
	private var heightMaps:Array<Array<Int>>;

	public override function create():Void
	{
		bgColor = FlxColor.GRAY;
		
		
		act = new Act("assets/data/act.tmx", this); // Pass the PlayState reference here

		add(act.foregroundGroup);
		add(act.objectGroup);

		playerCam = new PlayerCam(sonic);
		playerCam.setScrollBoundsRect(0, 0, act.fullWidth, act.fullHeight);
		sonic.camera = playerCam;
		FlxG.cameras.add(playerCam);

		debugDisplay = new DebugDisplay(this); // Pass the PlayState reference here
		add(debugDisplay);
		
	}

	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		sonic.acceleration.x = 0;

		if (Controls.DOWN && Math.abs(sonic.velocity.x) < 0.1 )
        {
            sonic.updateState(DOWN);

        }
        else if (Controls.UP && Math.abs(sonic.velocity.x) < 0.1)
        {
            sonic.updateState(UP);
			
        }
        else if (Controls.LEFT)
        {
            sonic.flipX = true;
			sonic.acceleration.x = -sonic.maxVelocity.x;

            sonic.updateState(JOG);
        }
		else if (Controls.RIGHT)
		{
			sonic.flipX = false;
			sonic.acceleration.x = sonic.maxVelocity.x;

			sonic.updateState(JOG);
		}
		else if (Math.abs(sonic.velocity.x) < 0.1)
		{
			sonic.updateState(IDLE);
		}

		sonic.playAnim(sonic.playerStateToString());

		act.collidewithLevel(sonic);

		debugDisplay.updateALL();

			if(Controls.TAB)
			{
				debugDisplay.toggleVisibility();
			}
	}
}
