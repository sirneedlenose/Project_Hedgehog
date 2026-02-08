package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;

abstract class Character extends FlxSprite
{
    public var animPrefixes:Map<String, String>;
    public var animOffsets:Map<String,Array<Dynamic>>;
    public var animSizes:Map<String,Array<Dynamic>>;
    public var hitBoxes:Map<String,Array<Dynamic>>; // not fully implemented yet

	public var allowFrameRateChange:Bool = true;

	public static var allowAntialiasing:Bool = true;

    public function new(posX:Float, posY:Float)
	{

        animPrefixes = new Map<String, String>();
        animOffsets = new Map<String,Array<Dynamic>>();
        animSizes = new Map<String,Array<Dynamic>>();
        hitBoxes = new Map<String,Array<Dynamic>>();

		solid = true;

		allowFrameRateChange = (allowFrameRateChange) ? true : false;
		antialiasing = (allowAntialiasing) ? true : false;


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
				// Scale graphic for this animation and update hitbox to keep world position anchored
                this.setGraphicSize(size[0], size[1]);
				this.updateHitbox();

				// Center the graphic within the hitbox so the sprite stays aligned to super.x/super.y
				this.centerOffsets();

				// If a hitbox is defined for this animation, enforce it to keep collisions stable
				if (hitBoxes.exists(animation.curAnim.name))
				{
					var hb = hitBoxes.get(animation.curAnim.name);
                    this.setSize(hb[0], hb[1]);
				}
            }

            if(animOffsets.exists(animation.curAnim.name))
            {
				// Apply animation-specific offset as an adjustment relative to the centered offset
				this.offset.x += offset[0];
				this.offset.y += offset[1];
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
}