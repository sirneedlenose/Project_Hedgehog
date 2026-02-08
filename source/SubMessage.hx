package;

import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class SubMessage extends FlxText
{
    private var originalX:Float;
    private var originalY:Float;

    private var shakeIntensity:Float = .5;
    private var shakeDuration:Int = 2;

    public var hover:Bool = false;


    public function new(x:Float, y:Float, msg:String, size:Int)
    {
        super(x,y,0,msg,size);

        this.font = "assets/fonts/SA2.ttf";

        antialiasing = true;

        color = FlxColor.WHITE;

        setBorderStyle(SHADOW, FlxColor.BLACK, 2, 1);

        originalX = x;
        originalY = y;
    }

    public override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if(hover)
        {
            this.y += Math.sin(elapsed * 10);
        }else{
            this.y = originalY;
        }

    }

    public function highlight(?colorValue:FlxColor,color:FlxColor = FlxColor.WHITE)
    {
        var selectedColor;
        if(colorValue == null)
        {
            selectedColor = color;
        }else{
            selectedColor = colorValue;
        }

        this.color = selectedColor;
    }

    public function flicker(duration:Float = 0.5)
    {
        var timer = new FlxTimer();
        timer.start(duration, function(t:FlxTimer)
        {
            this.visible = !this.visible;
        },1);

        this.visible = true;
    }
}
