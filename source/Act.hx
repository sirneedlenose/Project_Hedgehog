package;

import flixel.FlxObject;
import flixel.addons.editors.tiled.TiledObject;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledLayer.TiledLayerType;
import flixel.group.FlxGroup;
import flixel.addons.editors.tiled.TiledMap;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxTilemap.GraphicAuto;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import openfl.display.BitmapData;

using StringTools;

class Act extends TiledMap
{
    public var objectLayer:FlxGroup;
    public var tileLayer:FlxGroup;

    public var state:PlayState; // Reference to the PlayState

    public function new(tileMapPath:String, state:PlayState)
    {
        super(tileMapPath);

        this.state = state; // Store the reference to the PlayState

        objectLayer = new FlxGroup();
        tileLayer = new FlxGroup();

        loadObjects();

        for(layer in layers)
        {
            if(layer.type != TiledLayerType.TILE)
            {
                continue; // skip any non-tile layers
            }
            
            if(layer.type == TiledLayerType.TILE)
            {
                var tileLayer:TiledTileLayer = cast layer;
                loadTileLayer(tileLayer);
            }
        }
    }

    private function loadObjects():Void
    {
        for(layer in layers)
        {
            if(layer.type != TiledLayerType.OBJECT)
            {
                continue; // skip any non-object layers
            }

            if(layer.type == TiledLayerType.OBJECT)
            {
                var objLayer:TiledObjectLayer = cast layer;

                for(obj in objLayer.objects)
                {
                    loadObject(obj); // Load each object
                }

            }
        }
    }

    private function loadTileLayer(tile:TiledTileLayer):Void
    {
        var collisionLayer = tile; // Assuming this is the collision layer
        var collisionMap:FlxTilemap = new FlxTilemap();

        collisionMap.loadMapFromArray(
            collisionLayer.tileArray,
            this.width,
            this.height,
            "assets/images/testTiles.png",
            this.tileWidth,
            this.tileHeight
        );

        collisionMap.setTileProperties(1);

        tileLayer.add(collisionMap);

    }

    private function loadObject(obj:TiledObject):Void
    {
        switch(obj.name.toLowerCase())
        {
            case "spawnpoint":
                // Create the player sprite at the specified position
                spawnPlayer(state, obj.x, obj.y);
            default:
                throw "Unknown object type: " + obj.name;
        }
    }

    private function spawnPlayer(state:PlayState, posX:Float, posY:Float):Void
    {
        var player:Sonic = new Sonic(posX, posY);
        state.setPlayer(player); // Set the player in the PlayState that was passed
        objectLayer.add(player);
    }
}