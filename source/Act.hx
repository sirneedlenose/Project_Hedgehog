package;

import flixel.util.FlxDirection;
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
import flixel.util.FlxDirectionFlags;

using StringTools;

class Act extends TiledMap
{
    public var foregroundGroup:FlxGroup;
    public var objectGroup:FlxGroup;

    var colliableTilesLayers:Array<FlxTilemap>;

    public function new(tiledAct:FlxTiledMapAsset, state:PlayState)
    {
        super(tiledAct);

        foregroundGroup = new FlxGroup();
        objectGroup = new FlxGroup();

        FlxG.camera.setScrollBoundsRect(0,0,fullWidth,fullHeight);

        loadObjects(state);

        for(layer in layers)
        {
            if(layer.type != TiledLayerType.TILE)
            {
                continue;
            }

            var tileLayer:TiledTileLayer = cast(layer);
            var tileSheetName:String = tileLayer.properties.get("tileset");
            trace("Loading tileset: " + tileSheetName);

            if(tileSheetName == null)
            {
                throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
            }

            var tileSet:TiledTileSet = null;

            trace("Available tilesets:");

            for(ts in tilesets)
            {
                trace("-" + ts.name);

                if(ts.name == tileSheetName)
                {
                    tileSet = ts;
                    break;
                }
            }

            if(tileSet == null)
            {
                throw "Tileset '" + tileSheetName + "' not found. Did you misspell the 'tilesheet' property in '" + tileLayer.name + "' layer?";
            }

            var imagePath:String = tileSet.imageSource;
            trace("Loading tileset image: " + imagePath);

            var tilemap:FlxTilemap = new FlxTilemap();
            tilemap.loadMapFromArray(
                tileLayer.tileArray,
                width,
                height,
                "assets/images/testTiles.png", // TODO: Replace with imagePath variable when asset management is set up
                tileSet.tileWidth,
                tileSet.tileHeight,
                OFF,
                tileSet.firstGID,
                1,
                1,
            );

            correctTiles(tilemap, tileLayer, tileSet);



            foregroundGroup.add(tilemap);
        }

    }

    private function loadObjects(state:PlayState):Void
    {
        for(layer in layers)
        {
            if(layer.type != TiledLayerType.OBJECT)
            {
                continue;
            }

            var objectLayer:TiledObjectLayer = cast(layer);

            if(layer.name.toLowerCase() == "objects")
            {
                for(object in objectLayer.objects)
                {
                    loadObject(object, objectLayer, objectGroup, state);
                }
            }

        }
    }

    private function loadObject(obj:TiledObject, layer:TiledObjectLayer, group:FlxGroup, state:PlayState):Void
    {
        var posX:Float = obj.x;
        var posY:Float = obj.y;
        if(obj.gid != -1)
        {
            posY -= layer.map.getGidOwner(obj.gid).tileHeight;
        }
        trace("Loading object of type '" + obj.type + "' at (" + posX + ", " + posY + ")");
        trace("GID: " + obj.gid);
        switch(obj.type.toLowerCase())
        {
            case "player_spawn":
                trace("Spawning player at (" + posX + ", " + posY + ")");
                spawnPlayer(posX, posY, group, state);
        }
    }

    private function spawnPlayer(posX:Float, posY:Float, group:FlxGroup, state:PlayState):Void
    {
        var sonic:Sonic = new Sonic(posX, posY);
        state.sonic = sonic;
        group.add(sonic);
    }

    private function correctTiles(tilemap:FlxTilemap, tileLayer:TiledTileLayer, tileSet:TiledTileSet):Void
    {
        for(y in 0...tileLayer.height)
        {
            for(x in 0...tileLayer.width)
            {
                var index:Int = y * tileLayer.width + x;
                var gid:Int = tileLayer.tileArray[index];

                if(gid == 0)
                {
                    continue;
                }

                var localId:Int = gid - tileSet.firstGID;

                
            }
        }

    }
}