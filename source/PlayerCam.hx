package;

import flixel.FlxG;
import flixel.FlxCamera;

class PlayerCam extends FlxCamera
{

    private var timer:Float = 0;
    private var player:Sonic;
    
    private var defaultX:Float;
    private var defaultY:Float;

    public var panYSpeed:Float = 50;
    private var maxPanYDistance:Float;


    public function new(player:Sonic)
    {
        super();
        this.player = player;
        follow(player,PLATFORMER,0.15);

        defaultX = x;        
        defaultY = y;

        maxPanYDistance = scroll.y - 250;
    }

    public override function update(elpased:Float)
    {
        super.update(elpased);

        if(player.state == UP)
        {
            timer += elpased;

            if(timer % 60 >= 3)
            {
                scroll.y -= panYSpeed/2;

                if(scroll.y <= maxPanYDistance)
                {
                    scroll.y = maxPanYDistance;
                }
            }

        }
        else if(player.state == DOWN)
        {
            timer += elpased;

            if(timer % 60 >= 3)
            {
                scroll.y += panYSpeed/2;

                if(scroll.y == maxPanYDistance)
                {
                    scroll.y = maxPanYDistance;
                }
            }
        }
        else
        {
            timer = 0;
        }
    }

    public function changeMaxPanYDistance(newDistance:Float):Void
    {
        maxPanYDistance = scroll.y - newDistance;
    }
}