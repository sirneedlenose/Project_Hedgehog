package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledLayer.TiledLayerType;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap.GraphicAuto;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxDirection;
import flixel.util.FlxDirectionFlags;
import flixel.util.FlxGradient;
import openfl.display.BitmapData;

using StringTools;

class Act extends TiledMap
{
    public var foregroundGroup:FlxGroup;
    public var objectGroup:FlxGroup;
    public var outOfBounds:FlxObject;

    var colliableTilesLayers:Array<FlxTilemap>;

    public function new(tiledAct:FlxTiledMapAsset, state:PlayState)
    {
        super(tiledAct);

        foregroundGroup = new FlxGroup();
        objectGroup = new FlxGroup();

        outOfBounds = new FlxObject(0, fullHeight, fullWidth, 10);

        loadObjects(state);

		colliableTilesLayers = new Array<FlxTilemap>();

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

            var tilemap:FlxTilemap = new FlxTilemap();
			// Load with the actual tileset image path from Tiled
            tilemap.loadMapFromArray(
                tileLayer.tileArray,
                width,
                height,
			    "assets/images/testTiles.png",
                tileSet.tileWidth,
                tileSet.tileHeight,
                OFF,
                tileSet.firstGID,
                1,
                1,
            );

			foregroundGroup.add(tilemap);
            colliableTilesLayers.push(tilemap);
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

            case "fall_zone":
                var fallZone = new FlxObject(posX, posY, obj.width, obj.height);
                /*
                var debug:FlxSprite = new FlxSprite(posX, posY);
                debug.makeGraphic(obj.width, obj.height, FlxColor.RED);
                group.add(debug);
                */
                state.deathZone = fallZone;
                //group.add(fallZone);
        }
    }

    private function spawnPlayer(posX:Float, posY:Float, group:FlxGroup, state:PlayState):Void
    {
        var sonic:Sonic = new Sonic(posX, posY);
        state.sonic = sonic;
        group.add(sonic);
    }

    public function collidewithLevel(obj:FlxObject,?notifyCallBack:FlxObject->FlxObject->Void,
    ?processCallBack:FlxObject->FlxObject->Bool):Bool
    {
        if(colliableTilesLayers == null)
        {
            return false;
        }

        for(map in colliableTilesLayers)
        {
            if(FlxG.overlap(obj, map, notifyCallBack, processCallBack != null ? processCallBack : FlxObject.separate))
            {
                return true;
            }
        }
        return false;
    }

}
