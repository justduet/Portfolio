import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';


enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent 
    with HasGameRef<PixelAdventure>{
  
  // constructor that creates a character instance that is initialized with
  // whatever is passed in
  String character;
  Player({required this.character});
 

  // create variables for animations
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }
  
  void _loadAllAnimations() {

    idleAnimation = SpriteAnimation.fromFrameData(game.images.fromCache('Main Characters/Ninja Frog/Idle (32x32).png'), 
    SpriteAnimationData.sequenced(
      amount: 11, 
      stepTime: stepTime, 
      textureSize: Vector2.all(32),
      ),
      );

     runningAnimation = _spriteAnimation();

      // List of all animations
      animations = {
        PlayerState.idle: idleAnimation,
        PlayerState.running: runningAnimation
      };

      // Set current animation
      current = PlayerState.running;
  }

  SpriteAnimation _spriteAnimation() {
    return SpriteAnimation.fromFrameData(game.images.fromCache('Main Characters/$character'), 
     SpriteAnimationData.sequenced(
      amount: 12, 
      stepTime: stepTime, 
      textureSize: Vector2.all(32),
      ),
      );

  }
}