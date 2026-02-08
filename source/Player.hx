package;

class Player extends Character
{
    private var currentVelocityX:Float;
    private var currentVelocityY:Float;

    private var maxVelocityX:Float;
    private var maxVelocityY:Float;

    public function new(x:Float, y:Float)
    {
        super(x, y);
        maxVelocity.x = 200;
        maxVelocity.y = 500;
        acceleration.y = 500;
        drag.x = maxVelocity.x * 4;
    }

    public override function update(elapsed:Float):Void
    {
        currentVelocityX = Math.abs(velocity.x);
        currentVelocityY = Math.abs(velocity.y);


        super.update(elapsed);
    }

    

}