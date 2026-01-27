package;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.atlas.FlxAtlas;
import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Character extends FlxSprite
{
    public var animPrefixes:Map<String, String>;
    public var animOffsets:Map<String,Array<Dynamic>>;
    public var animSizes:Map<String,Array<Dynamic>>;
    public var collisionBoxes:Map<String,Array<Dynamic>>; // not fully implemented yet
    public var hitBoxes:Map<String,Array<Dynamic>>; // not fully implemented yet

    public function new(posX:Float, posY:Float)
    {
        animPrefixes = new Map<String, String>();
        animOffsets = new Map<String,Array<Dynamic>>();
        animSizes = new Map<String,Array<Dynamic>>();
        hitBoxes = new Map<String,Array<Dynamic>>();

        super(posX, posY);
    }

    public function playAnimation(name:String, Force:Bool = false, Reverse:Bool = false, Frame:Int = 0):Void
    {
        if(animPrefixes.exists(name)){

            animation.play(name,Force,Reverse,Frame);

            var offset = animOffsets.get(animation.curAnim.name);
            var size = animSizes.get(animation.curAnim.name);

            if(animSizes.exists(animation.curAnim.name))
            {
                this.setGraphicSize(size[0], size[1]);
            }

            if(animOffsets.exists(animation.curAnim.name))
            {
                this.offset.set(offset[0], offset[1]);
            }
        }else{

            trace("Animation " + name + " does not exist!");
        }
    }

    public function addPrefix(animName:String, prefix:String, frameRate:Int = 24, looped:Bool = true, flipX:Bool = false, flipY:Bool = false):Void
    {
        animation.addByPrefix(animName, prefix, frameRate, looped, flipX, flipY);
        animPrefixes[animName] = prefix;
    }

    public function addOffset(animName:String, offsetX:Float, offsetY:Float):Void
    {
        animOffsets[animName] = [offsetX, offsetY];
    }

    public function addSize(animName:String, width:Float, height:Float):Void
    {
        animSizes[animName] = [width, height]; 
    }

    public function addHitbox(animName:String, width:Float, height:Float, offsetX:Float = 0, offsetY:Float = 0):Void
    {
        hitBoxes[animName] = [width, height, offsetX, offsetY];
    }


    public function createHitBox(animName:String):Void
    {
        //TODO: Implement hitbox changing based on animation
    }
}