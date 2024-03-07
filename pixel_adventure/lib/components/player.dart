import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/components/collision_block.dart';
import 'package:pixel_adventure/components/player_hitbox.dart';
import 'package:pixel_adventure/components/utils.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState { idle, running, jumping, falling }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  String character;
  Player({
    position,
    // default
    this.character = 'Mask Dude',
  }) : super(position: position);

  final double stepTime = 0.05;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
  late final SpriteAnimation fallingAnimation;

  final double friction = 0.75;

  // gravity variables
  final double _gravity = 9.8;
  final double _jumpForce = 300;
  final double _terminalVelocity = 300;

  // let's us check if we're going left or right
  double horizontalMovement = 0;
  // set default speed
  double moveSpeed = 100;

  // set a vector to dynamically control player's movements
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  bool hasJumped = false;
  // tell the player to recognize collisions
  List<CollisionBlock> collisionBlocks = [];
  PlayerHitbox hitbox = PlayerHitbox(
    offsetX: 10,
    offsetY: 4,
    width: 14,
    height: 28,
  );

  @override
  FutureOr<void> onLoad() {
    // call the method that will do everything for us
    _loadAllAnimations();
    // debugMode = true;
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    _checkHorizontalCollisions();
    _applyGravity(dt);
    _checkVerticalCollisions();
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

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    // load animations
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);
    jumpingAnimation = _spriteAnimation('Jump', 1);
    fallingAnimation = _spriteAnimation('Fall', 1);

    // associate each player state to an animation
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation
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
    PlayerState playerState = PlayerState.idle;
    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    // check if falling set to falling
    if (velocity.y > 0) {
      playerState = PlayerState.falling;
    }
    // check if jumping set to jumping
    else if (velocity.y < 0) {
      playerState = PlayerState.jumping;
    } else if (horizontalMovement != 0) {
      playerState = PlayerState.running;
    } else {
      playerState = PlayerState.idle;
    }
    current = playerState;
  }

  void _updatePlayerMovement(double dt) {
    if (hasJumped && isOnGround) _playerJump(dt);
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

  void _playerJump(double dt) {
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    isOnGround = false;
    hasJumped = false;
  }

  void _checkHorizontalCollisions() {
    for (final block in collisionBlocks) {
      if (!block.isPlatform && checkCollision(this, block)) {
        // If player is moving right and collides with block, stop player
        if (velocity.x > 0) {
          // subtract width of player so player gets pushed to the left
          velocity.x = 0;
          position.x = block.x - hitbox.offsetX - hitbox.width;

          break;
        }
        // stop player and push to the right
        else if (velocity.x < 0) {
          velocity.x = 0;
          position.x = block.x + block.width + hitbox.width + hitbox.offsetX;

          break;
        }
      }
    }
  }

  void _applyGravity(double dt) {
    // gravity speed accelerates
    velocity.y += _gravity;
    // player can not go faster in the up direction than jump force
    // can't go any faster down than terminal velocity
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _checkVerticalCollisions() {
    for (final block in collisionBlocks) {
      if (block.isPlatform) {
        if (checkCollision(this, block)) {
          // Check if the player is moving downward
          if (velocity.y > 0) {
            // Stop the player's downward velocity
            velocity.y = 0;
            // Set the player's position just above the platform
            // previously i was subtracting block.height which caused me TONS of issues
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
          }
        }
      } else {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
          // take care of jumping (moving upward)
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + block.height - hitbox.offsetY;
          }
        }
      }
    }
  }
}
