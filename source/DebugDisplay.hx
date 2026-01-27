package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

class DebugDisplay extends FlxTypedGroup<FlxText>
{
   public var playerStateText:FlxText;
   public var playerTerrainText:FlxText;

   public var playerState:String;
   public var terrainState:String;

   public function new()
   {
        super();
        playerStateText = new FlxText(10, 10, 0, "State: ",25);
        //playerTerrainText = new FlxText(10, 30, 200, "Terrain: ");
        add(playerStateText);
        //add(playerTerrainText);
   }

   public function updatePlayerState(state:String):Void
   {
          playerStateText.text = "State: " + state;
   }

}