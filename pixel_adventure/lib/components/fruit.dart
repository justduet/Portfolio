import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:pixel_adventure/components/custom_hitbox.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

// Define a class named Fruit that extends SpriteAnimationComponent.
class Fruit extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  // Declare a final property to hold the type of fruit.
  final String fruit;

  // Define the constructor for the Fruit class.
  // It takes named parameters: fruit, position, and size.
  // The default value for fruit is 'Apple'.
  // The position and size parameters are passed to the superclass constructor.
  Fruit({this.fruit = 'Apple', position, size})
      : super(
          position: position,
          size: size, // Initialize the position of the fruit.
        );

  // Define a constant for the step time of the animation.
  final double stepTime = 0.05;
  final hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 10,
    width: 12,
    height: 12,
  );

  bool collected = false;

  // Override the onLoad method to load the sprite animation.
  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    priority = -1;

    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
      collisionType: CollisionType.passive,
    ));

    // Load the sprite animation using image and data.
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Items/Fruits/$fruit.png'),
      SpriteAnimationData.sequenced(
        amount: 17,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
    return super.onLoad(); // Call the onLoad method of the superclass.
  }

  void collidedWithPlayer() async {
    if (!collected) {
      collected = true;
      if (game.playSounds) {
        FlameAudio.play('collect_fruit.wav', volume: game.soundVolume * .45);
      }
      // Load the sprite animation using image and data.
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/Collected.png'),
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
          loop: false,
        ),
      );
      await animationTicker?.completed;
      removeFromParent();
    }
  }
}
