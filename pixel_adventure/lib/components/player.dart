import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  String character;
  Player({
    position,
    // default
    this.character = 'Mask Dude',
  }) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;
  final double friction = 0.88;

  // let's us check if we're going left or right
  double horizontalMovement = 0;
  // set default speed
  double moveSpeed = 100;

  // set a vector to dynamically control player's movements
  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    // call the method that will do everything for us
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    // load animations
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);

    // associate each player state to an animation
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation
    };

    // set current animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _updatePlayerState() {

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    if (horizontalMovement != 0) {
      current = PlayerState.running;
    } else {
      current = PlayerState.idle;
    }
  }

void _updatePlayerMovement(double dt) {
  // Update velocity based on input
  if (horizontalMovement != 0) {
    // If there's horizontal movement, set velocity based on horizontalMovement
    velocity.x = horizontalMovement * moveSpeed;
  }

  // Apply friction if the player is idle
  if (horizontalMovement == 0 && velocity.x != 0) {
    // Gradually reduce velocity towards zero
    velocity.x *= friction;
  }

   // Check if velocity is below a threshold and set it to zero to ensure the player stops
    if (velocity.x.abs() < .1) {
      velocity.x = 0;
    }


  // Update player position
  position.x += velocity.x * dt;
}
    }