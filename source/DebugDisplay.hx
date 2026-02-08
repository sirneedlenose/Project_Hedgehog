package;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

class DebugDisplay extends FlxGroup
{
    private var state:PlayState;
    
    private var playerX:Float;
    private var playerY:Float;

    private var playerState:String;

    private var speedX:Float;
    private var speedY:Float;

    private var accelerationX:Float;
    private var accelerationY:Float;


    private var position_X_Text:SubMessage;
    private var position_Y_Text:SubMessage;
    private var speedX_Text:SubMessage;
    private var speedY_Text:SubMessage;
    private var accelerationX_Text:SubMessage;
    private var accelerationY_Text:SubMessage;
    private var playerState_Text:SubMessage;

    public function new(state:PlayState, posX:Float = 0.0, posY:Float = 0.0 ,padding:Int = 25)
    {
        super();

        this.state = state;

        position_X_Text = new SubMessage(posX,posY, "X:",20);
        position_Y_Text = new SubMessage(posX, position_X_Text.y + padding, "Y:",20);

        speedX_Text = new SubMessage(posX, position_Y_Text.y + padding, "SpeedX:",20);
        speedY_Text = new SubMessage(posX, speedX_Text.y + padding, "Speed Y:",20);

        accelerationX_Text = new SubMessage(posX, speedY_Text.y + padding, "AccelerationX:",20);
        accelerationY_Text = new SubMessage(posX, accelerationX_Text.y + padding, "AccelerationY:",20);

        playerState_Text = new SubMessage(posX, accelerationY_Text.y + padding, "State:",20);

        position_X_Text.scrollFactor.set(0,0);
        position_Y_Text.scrollFactor.set(0,0);

        speedX_Text.scrollFactor.set(0,0);
        speedY_Text.scrollFactor.set(0,0);

        accelerationX_Text.scrollFactor.set(0,0);
        accelerationY_Text.scrollFactor.set(0,0);
        
        playerState_Text.scrollFactor.set(0,0);

        add(position_X_Text);
        add(position_Y_Text);

        add(speedX_Text);
        add(speedY_Text);

        add(accelerationX_Text);
        add(accelerationY_Text);

        add(playerState_Text);

        this.visible = false;
        
    }

    public function updateALL():Void
    {
        updatePosition(state.sonic.x, state.sonic.y);
        updateState(state.sonic.playerStateToString());
        updateSpeed(state.sonic.velocity.x, state.sonic.velocity.y);
        updateAcceleration(state.sonic.acceleration.x, state.sonic.acceleration.y);
    }

    private function updatePosition(posX:Float, posY:Float):Void
    {
        playerX = Std.int(posX);
        playerY = Std.int(posY);

        position_X_Text.text = "X: " + Std.string(playerX);
        position_Y_Text.text = "Y: " + Std.string(playerY);
    }

    private function updateState(state:String):Void
    {
        playerState = state;
        playerState_Text.text = "State: " + playerState;
    }

    private function updateSpeed(valueX:Float, valueY:Float):Void
    {
        speedX = Std.int(valueX);
        speedY = Std.int(valueY);

        speedX_Text.text = "SpeedX: " + Std.string(speedX);
        speedY_Text.text = "SpeedY: " + Std.string(speedY);
    }
    private function updateAcceleration(valueX:Float, valueY:Float):Void
    {
        accelerationX = Std.int(valueX);
        accelerationY = Std.int(valueY);

        accelerationX_Text.text = "AccelerationX: " + Std.string(accelerationX);
        accelerationY_Text.text = "AccelerationY: " + Std.string(accelerationY);
    }

    public function toggleVisibility():Void
    {
        this.visible = !this.visible;
    }
}