package;

import flixel.addons.editors.tiled.TiledGroupLayer;
import flixel.addons.editors.tiled.TiledLayer.TiledLayerType;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.group.FlxGroup;

using StringTools;

// THE HEART

enum ActTileType
{
    SOLID;
    TOP;
    SIDE_BOTTOM;
}

typedef ActTileData = {

    var tileType:ActTileType;

    var tileWidth:Int; // ignores the image size just bitmap data
    var tileHeight:Int; // ignore the image size just bitmap data

    var tileMaxHeight:Int; // the max height of the tile, used for slopes to determine how high the tile can be at a certain point

    var tileAngle:Float;
}

class Act extends TiledMap 
{
    public static var path:String = "act";
    public static var actTileSize:Int = 48;

    private var foregroundGroup:FlxGroup;
    private var solidTileGroup:FlxGroup;
    private var collisionGroup:FlxGroup;
    private var objectGroup:FlxGroup;

    public function new()
    {
        super('assets/data/$path.tmx');

        loadObjects();
        loadCollisionMap();

    }

    private function loadObjects():Void
    {
        for(daLayer in layers)
        {
            if(daLayer.type != TiledLayerType.OBJECT)
            {
                continue;
            }

            var objectLayer:TiledObjectLayer = cast daLayer;

            switch(objectLayer.name.toLowerCase())
            {
                case "objects":
                    for(daObj in objectLayer.objects)
                    {
                        loadObject(daObj, objectLayer);
                    }
            }
        }
    }

    private function loadObject(daObj:TiledObject, daLayer:TiledObjectLayer):Void
    {
        var PosX = daObj.x;
        var PosY = daObj.y;

        if(daObj.gid != -1)
        {
            PosY -= daLayer.map.getGidOwner(daObj.gid).tileHeight; // Tiled's y coordinate is the bottom of the tile, so we need to adjust it to be the top of the tile
        }

        switch(daObj.type.toLowerCase())
        {
            case "player_spawn":
                PlayState.setPlayerCoord(PosX, PosY);
            default:
                throw 'Unknown object type: ${daObj.type}';

        }
    }

    private function loadCollisionMap():Void
    {
        for(daLayer in layers)
        {
            if(daLayer.type != TiledLayerType.GROUP)
            {
                continue;
            }

            var groupLayer:TiledGroupLayer = cast daLayer;

            for(subLayer in groupLayer.layers)
            {
                if(subLayer.type != TiledLayerType.TILE)
                {
                    continue;
                }

                var tileLayer:TiledTileLayer = cast subLayer;

                try
                {
                    switch(tileLayer.name.toLowerCase())
                    {
                        case "solidlayer":
                            createSolidLayer(tileLayer);
                            break;
                            
                        case "toplayer":
                            createTopLayer(tileLayer);
                            break;

                        case "sidebottomlayer":
                            createSideBottomLayer(tileLayer);
                            break;

                        default:
                            throw 'Unknown layer name: ${tileLayer.name}'; 
                    }

                }
                catch(msg:Dynamic)
                {
                    trace("Error loading collision map: " + msg);
                }
            }
        }
    }

    private function createSolidLayer(daLayer:TiledTileLayer):Void
    {
        var solidTileSet:TiledTileSet = getTileSet(daLayer.properties.get("tileset"));

        if(solidTileSet == null)
        {
            throw 'Tileset not found: ${daLayer.properties.get("tileset")}';
        }

        var daImageSource = solidTileSet.imageSource;

        var widthInTiles = daLayer.width;
        var heightInTiles = daLayer.height;

        try{
            //var daCollisionMap = new CollisionMap(SOLID, daLayer.tileArray, daImageSource, widthInTiles, heightInTiles, actTileSize);
        }
        catch(msg:Dynamic)
        {
            trace("Error creating collision map: " + msg);
        }

    }

    private function createTopLayer(daLayer:TiledTileLayer):Void
    {
        var topTileSet:TiledTileSet = getTileSet(daLayer.properties.get("tileset"));

        if(topTileSet == null)
        {
            throw 'Tileset not found: ${daLayer.properties.get("tileset")}';
        }

        var daImageSource = topTileSet.imageSource;
        
        var widthInTiles = daLayer.width;
        var heightInTiles = daLayer.height;

        try{
           // var daCollisionMap = new CollisionMap(SOLID, daLayer.tileArray, daImageSource, widthInTiles, heightInTiles, actTileSize);
        }
        catch(msg:Dynamic)
        {
            trace("Error creating collision map: " + msg);
        }


    }

    private function createSideBottomLayer(daLayer:TiledTileLayer):Void
    {
        var sideBottomTileSet:TiledTileSet = getTileSet(daLayer.properties.get("tileset"));

        if(sideBottomTileSet == null)
        {
            throw 'Tileset not found: ${daLayer.properties.get("tileset")}';
        }

        var daImageSource = sideBottomTileSet.imageSource;

        var widthInTiles = daLayer.width;
        var heightInTiles = daLayer.height;

        try{
            //var daCollisionMap = new CollisionMap(SOLID, daLayer.tileArray, daImageSource, widthInTiles, heightInTiles, actTileSize);
        }
        catch(msg:Dynamic)
        {
            trace("Error creating collision map: " + msg);
        }
    }
}
