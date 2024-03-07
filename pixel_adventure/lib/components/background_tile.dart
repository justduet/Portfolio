import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

// sprite component allows us to pass in an image
class BackgroundTile extends SpriteComponent with HasGameRef<PixelAdventure>{
  final String color;
  BackgroundTile({
    this.color = 'Gray',
    position,
  }) : super(
          position: position,
        );

  final double scrollSpeed = 0.4;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    size = Vector2.all(64.6);
    sprite = Sprite(game.images.fromCache('Background/$color.png'));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // increment the y-coordinate of the component
    position.y += scrollSpeed;
    double tileSize = 64;
    // Calculate the number of tiles that fit vertically
    int scrollheight = (game.size.y / tileSize).floor();
    // scrollheight represents the number of tiles, 
    // while tileSize is the pixels
    // we need matching units, position is pixels
    if(position.y > scrollheight * tileSize){
      position.y = -tileSize;
    }
    super.update(dt);
  }
}
