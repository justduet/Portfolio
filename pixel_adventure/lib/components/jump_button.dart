import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

// extends sprite because we are using an image sprite
class JumpButton extends SpriteComponent with HasGameRef<PixelAdventure>, TapCallbacks {
  JumpButton();

  final margin = 32;
  


  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));
    anchor = Anchor.bottomRight;
    position = Vector2(game.size.x - margin, game.size.y - margin);
    priority = 10;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJumped = true;

    super.onTapDown(event);
  }
  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = false;
    super.onTapUp(event);
  }
}
