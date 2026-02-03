package;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Sonic extends Character
{
    public var state:CharacterState;
    public var terrainState:TerrainState;

    public var velocityX:Float = 0;
    public var velocityY:Float = 0;

    private var animName:String;


    public function new(posX:Float, posY:Float)
    {
        super(posX, posY);
        trace("Position: (" + posX + ", " + posY + ")");
        trace("size: " + width + "x" + height);
    
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

        antialiasing = true; // Enable antialiasing for smoother graphics

        addOffset("idle", -10, -5);
        addSize("idle", 124, 144);
        
        addOffset("jog", -12, -4);
        addSize("jog", 128, 144);

        addOffset("up", -10, -5);
        addSize("up", 124, 150);

        addOffset("down", -10, -5);
        addSize("down", 124, 144);

        state = IDLE;
        
        playAnimation("idle", true, false, 0);


    }

    public override function update(elapsed:Float) 
    {
        super.update(elapsed);

        // Prioritize vertical inputs first to avoid resets
        if (Controls.DOWN )
        {
            //desired = "down";
            animName = "down";
            updateState(DOWN);
        }
        else if (Controls.UP)
        {
            //desired = "up";
            animName = "up";
            updateState(UP);
        }
        else if (Controls.LEFT)
        {
            flipX = true;
            animName = "jog";
            updateState(RUNNING);
        }
        else if (Controls.RIGHT)
        {
            flipX = false;
            animName = "jog";
            updateState(RUNNING);
        }
        else
        {
            animName = "idle";
            updateState(IDLE);
        }

        // Only switch animations when the desired one changes
        if (animName != null && (animation.curAnim == null || animation.curAnim.name != animName))
        {
            playAnimation(animName, false, false, 0);
        }

    }

    public function updateState(newState:CharacterState):Void
    {
        if(state == newState){ 
            return;
        }

        state = newState;
    }

    public function getState():CharacterState
    {
        return state;
    }

    public function playerStateToString():String
    {
        return state.getName();
    }
}