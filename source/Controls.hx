import flixel.input.keyboard.FlxKeyList;
import flixel.input.keyboard.FlxKeyboard;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;

class Controls
{
    //public static inline var KeyBoard:FlxKeyboard;
    public static inline var left:FlxKey = FlxKey.LEFT;
    public static inline var right:FlxKey = FlxKey.RIGHT;
    public static inline var down:FlxKey = FlxKey.DOWN;
    public static inline var up:FlxKey = FlxKey.UP;
    public static inline var action_1:FlxKey = FlxKey.Z;
    public static inline var action_2:FlxKey = FlxKey.X;
    public static inline var esc:FlxKey = FlxKey.ESCAPE;
    public static inline var enter:FlxKey = FlxKey.ENTER;
    public static inline var back:FlxKey = FlxKey.BACKSPACE;
    public static inline var tab:FlxKey = FlxKey.TAB;

    public static var LEFT(get, never):Bool;
    public static var RIGHT(get, never):Bool;
    public static var ACTION_1(get, never):Bool;
    public static var ACTION_2(get, never):Bool;
    public static var ESC(get, never):Bool;
    public static var ENTER(get, never):Bool;
    public static var BACK(get, never):Bool;
    public static var TAB(get, never):Bool;
    public static var DOWN(get, never):Bool;
    public static var JustDOWN(get, never):Bool;
    public static var UP(get, never):Bool;
    

    private static function get_LEFT():Bool{
        return FlxG.keys.anyPressed([left]);
    }
    private static function get_RIGHT():Bool{
        return FlxG.keys.anyPressed([right]);
    }
    private static function get_ACTION_1():Bool{
        return FlxG.keys.anyPressed([action_1]);
    }
    private static function get_ACTION_2():Bool{
        return FlxG.keys.anyPressed([action_2]);
    }
    private static function get_ESC():Bool{
        return FlxG.keys.anyPressed([esc]);
    }
    private static function get_ENTER():Bool{
        return FlxG.keys.anyPressed([enter]);
    }
    private static function get_BACK():Bool{
        return FlxG.keys.anyPressed([back]);
    }
    private static function get_TAB():Bool{
        return FlxG.keys.anyJustPressed([tab]);
    }
    private static function get_DOWN():Bool{
        return FlxG.keys.anyPressed([down]);
    }
    private static function get_JustDOWN():Bool{
        return FlxG.keys.anyJustPressed([down]);
    }
    private static function get_UP():Bool{
        return FlxG.keys.anyPressed([up]);
    }
    
}