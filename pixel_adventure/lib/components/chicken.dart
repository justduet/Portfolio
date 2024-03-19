import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum State { idle, run, hit }

class Chicken extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  final double offNeg;
  final double offPos;

  Chicken({
    super.position,
    super.size,
    this.offNeg = 0,
    this.offPos = 0,
  });

  static const stepTime = 0.05;
  static const tileSize = 16;
  static const runSpeed = 120;
  static const _bounceHeight = 300.0;
  final textureSize = Vector2(32, 34);

  Vector2 velocity = Vector2.zero();
  double rangeNeg = 0;
  double rangePos = 0;
  double moveDirection = 1;
  double targetDirection = -1;
  bool gotStomped = false;

  late final Player player;
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _hitAnimation;

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    priority = -1;
    player = game.player;

    add(
      RectangleHitbox(
        position: Vector2(4, 6),
        size: Vector2(24, 26),
      ),
    );
    _loadAllAnimations();
    _calculateRange();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!gotStomped) {
      _updateState();
      _movement(dt);
    }

    super.update(dt);
  }

  void _loadAllAnimations() {
    _idleAnimation = _spriteAnimation('Idle', 13);
    _runAnimation = _spriteAnimation('Run', 14);
    _hitAnimation = _spriteAnimation('Hit', 5)..loop = false;

    // link animations to State
    // no need to change animations, just state
    animations = {
      State.idle: _idleAnimation,
      State.run: _runAnimation,
      State.hit: _hitAnimation
    };

    current = State.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Enemies/Chicken/$state (32x34).png'),
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: stepTime,
          textureSize: textureSize,
        ));
  }

  void _calculateRange() {
    rangeNeg = position.x - offNeg * tileSize;
    rangePos = position.x + offPos * tileSize;
  }

  void _movement(dt) {
    // set velocity to 0
    velocity.x = 0;

    double playerOffset = (player.scale.x > 0) ? 0 : -player.width;
    double chickenOffset = (scale.x > 0) ? 0 : -width;

    if (playerInRange()) {
      // ensures chicken moves toward player
      targetDirection =
          (player.x + playerOffset < position.x + chickenOffset) ? -1 : 1;
      velocity.x = targetDirection * runSpeed;
    }
    // smoothly adjusts the move direction towards the target direction
    moveDirection = lerpDouble(moveDirection, targetDirection, 0.1) ?? 1;

    position.x += velocity.x * dt;
  }

  bool playerInRange() {
    // Calculate offsets based on the direction the player is facing
    double playerOffset = (player.scale.x > 0) ? 0 : -player.width;

    // Check if the player's position falls within the range of the chicken
    return player.x + playerOffset >= rangeNeg &&
        player.x + playerOffset <= rangePos &&
        player.y + player.height > position.y &&
        player.y < position.y + height;
  }

  void _updateState() {
    current = (velocity.x != 0) ? State.run : State.idle;

    // if moving to the right and facing right, we need to flip
    if ((moveDirection > 0 && scale.x > 0) ||
        (moveDirection < 0 && scale.x < 0)) {
      flipHorizontallyAroundCenter();
    }
  }

  void collidedWithPlayer() async {
    if (player.velocity.y > 0 && player.y + player.height > position.y) {
      if (game.playSounds) {
        FlameAudio.play('bounce.wav', volume: game.soundVolume * .5);
      }
      gotStomped = true;
      current = State.hit;
      player.velocity.y = -_bounceHeight;
      await animationTicker?.completed;
      removeFromParent();
    } else {
      player.collidedwithEnemy();
    }
  }
}
