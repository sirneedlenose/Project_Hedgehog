package;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Sonic extends Character
{
	public var state:PlayerState;
    public var terrainState:TerrainState;

    public function new(posX:Float, posY:Float)
    {
        super(posX, posY);
		maxVelocity.x = 250;
		maxVelocity.y = 500;
		acceleration.y = 700;

		drag.x = maxVelocity.x * 2;
    
        var ref= FlxAtlasFrames.fromSparrow("assets/images/sonic.png", "assets/data/sonic.xml");
        frames = ref;
        /*
        animation.addByPrefix("idle","idle",24,true,false);
        animation.addByPrefix("jog","jog",24,true,false);
        animation.addByPrefix("sprint","sprint",24,true,true);
        animation.addByPrefix("run","run",24,true,true);
        animation.addByPrefix("jump","jump",24,true,true);
        animation.addByPrefix("down","down",24,false,false);
        animation.addByPrefix("skid","skid",24,true,false);
        animation.addByPrefix("ball","ball",24,true,false);
        animation.addByPrefix("spindash","spindash",24,true,false);
        animation.addByPrefix("up","up",24,false,false);
        */

        addPrefix("idle","idle",24,true,false);
        addPrefix("jog","jog",24,true,false);
        addPrefix("up","up",24,false,false);
        addPrefix("down","down",24,false,false);
        // ensure we only register animations once

        addOffset("idle", -5, -5);
        addSize("idle", 124, 144);
		addHitbox("idle", 124, 144);
        
		addOffset("jog", 0, -4);
		addSize("jog", 135, 144);
		addHitbox("jog", 124, 144);

		addOffset("up", -10, 5);
        addSize("up", 130, 150);
		addHitbox("up", 124, 144);

        addOffset("down", -10, -5);
        addSize("down", 124, 144);
		addHitbox("down", 124, 144);

        updateState(IDLE);

        playAnim("idle");

    }

    public override function update(elapsed:Float) 
    {
		if (animation.curAnim.name == "jog")
        {
			animation.curAnim.frameRate = 10 + velocity.length / 20;
        }

		super.update(elapsed);
	}

	public function playAnim(?name:String):Void
	{
        if(name == null)
        {
            playAnimation("idle", false, false, 0);
        }
        
        if(name != null && (animation.curAnim == null || animation.curAnim.name != name))
        {
            playAnimation(name, false, false, 0);
        }
    }

	public function updateState(newState:PlayerState):Void
    {
        if(state == newState){ 
            return;
        }

        state = newState;
    }

	public function getState():PlayerState
    {
        return state;
    }

    public function playerStateToString():String
    {
		return Std.string(state).toLowerCase();
    }
}

enum PlayerState
{
	IDLE;
	JOG;
	RUNNING;
	UP;
	DOWN;
}

enum TerrainState
{
	GROUND;
	AIR;
}