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
	private static var playerSpawnCoor:Array<Float>;

	private var cameraTarget:FlxSprite;
	private var debugCamera:FlxCamera;
	private var playerCamera:FlxCamera;

	public var sonic:Sonic;
	public var act:Act;

	private var playerState:String;

	private var tilemap:FlxTilemap;
	private var heightMaps:Array<Array<Int>>;

	public override function create():Void
	{
		bgColor = FlxColor.GRAY;

		playerCamera = new FlxCamera();
		debugCamera = new FlxCamera();

		FlxG.cameras.add(playerCamera);
		FlxG.cameras.add(debugCamera);

		act = new Act();

		sonic = spawnPlayer();

		playerCamera.follow(sonic, LOCKON, 0.15);
		sonic.cameras = [playerCamera];
		add(sonic);
			
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
	}

	public static function setPlayerCoord(posX:Float, posY:Float):Void
	{
		playerSpawnCoor = [posX, posY];
	}

	private function spawnPlayer():Sonic
	{
		sonic = new Sonic();

		sonic.x = playerSpawnCoor[0];
		sonic.y = playerSpawnCoor[1] - sonic.graphic.height; // Adjust for sprite height

		return sonic;
	}
}
