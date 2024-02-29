import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/components/player.dart';

class Level extends World {

  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player});

  // declare a property that represents the loaded level
  late TiledComponent level;


  // override the onLoad method 
  // which will be called when the level is loaded
  @override
  FutureOr<void> onLoad() async {
    // load a tile map file that corresponds to a level name
    // ran from scrath...hot reloaded couple times THEN color showed up
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));

    add(level);

    // get the spawnPoints layer from the map
    // something goes wrong here and it doesnt load tile map sometimes?
    // when i took off the breakpoint it suddenly worked but arrow keys are broken?
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
          break;
        default:
      }
    }
    return super.onLoad();
  }
}
