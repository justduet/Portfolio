import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/components/checkpoint.dart';
import 'package:pixel_adventure/components/chicken.dart';
import 'package:pixel_adventure/components/collision_block.dart';
import 'package:pixel_adventure/components/custom_hitbox.dart';
import 'package:pixel_adventure/components/fruit.dart';
import 'package:pixel_adventure/components/saw.dart';
import 'package:pixel_adventure/components/utils.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState {
  idle,
  running,
  jumping,
  falling,
  hit,
  appearing,
  disappearing
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler, CollisionCallbacks {
  String character;
 
  Player({
    this.character = 'Pink Man',
    Vector2? position,
  }) : super(position: position);

  late int totalFruit;
  // add a life counter and display
  int lifeCount = 3;

  final double stepTime = 0.05;
  // sets up placeholders
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
  late final SpriteAnimation fallingAnimation;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation appearingAnimation;
  late final SpriteAnimation disappearingAnimation;

  final double friction = 0.75;

  // gravity variables
  final double _gravity = 9.8;
  final double _jumpForce = 300;
  final double _terminalVelocity = 300;

  // let's us check if we're going left or right
  double horizontalMovement = 0;
  // set default speed
  double moveSpeed = 100;

  // establish sp so that collisions with traps/enemies
  // set us back to the beginning
  Vector2 startingPosition = Vector2.zero();

  // set a vector to dynamically control player's movements
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  bool hasJumped = false;
  bool gotHit = false;
  bool reachedCheckpoint = false;

  // tell the player to recognize collisions
  List<CollisionBlock> collisionBlocks = [];
  CustomHitbox hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 4,
    width: 14,
    height: 28,
  );

  double fixedDeltaTime = 1 / 60;
  // variable to track total time from last frame
  double accumulatedTime = 0;

  @override
  FutureOr<void> onLoad() {
    //debugMode = true;
    // call the method that will do everything for us
    _loadAllAnimations();
    // debugMode = true;

    // position when player is added (it's a reference)
    startingPosition = Vector2(position.x, position.y);
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;
    while (accumulatedTime > fixedDeltaTime) {
      if (!gotHit && !reachedCheckpoint && lifeCount!=0) {
        _updatePlayerState();
        _updatePlayerMovement(fixedDeltaTime);
        _checkHorizontalCollisions();
        _applyGravity(fixedDeltaTime);
        _checkVerticalCollisions();
      }
      accumulatedTime -= fixedDeltaTime;
    }

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

  // allows the Fruit and Saw class to perform
  // custom collision handling logic
  // when colliding with another component,
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (!reachedCheckpoint) {
      if (other is Fruit) {
        other.collidedWithPlayer();
        // Decrement the total number of fruits when a collision with a fruit occurs
        totalFruit--;
        // problem with how fruit is subtracting...
        print('Total fruit: ${totalFruit}');
      }

      if (other is Saw) _respawn();
      if (other is Chicken) other.collidedWithPlayer();
    }
    // Check if there are no fruits left and trigger the reached checkpoint
    if (totalFruit == 0 && other is Checkpoint && !reachedCheckpoint) {
      _reachedCheckpoint();
      // Call the checkpoint logic from the player
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _loadAllAnimations() {
    // load animations
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);
    jumpingAnimation = _spriteAnimation('Jump', 1);
    fallingAnimation = _spriteAnimation('Fall', 1);
    hitAnimation = _spriteAnimation('Hit', 7)..loop = false;
    appearingAnimation = _specialSpriteAnimation('Appearing', 7);
    disappearingAnimation = _specialSpriteAnimation('Disappearing', 7);

    // associate each player state to an animation
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation,
      PlayerState.hit: hitAnimation,
      PlayerState.appearing: appearingAnimation,
      PlayerState.disappearing: disappearingAnimation,
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

  SpriteAnimation _specialSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$state (96x96).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(96),
        loop: false,
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
    if (game.playSounds) {
      FlameAudio.play('jump.wav', volume: game.soundVolume * .5);
    }
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
            // previously I was subtracting block.height which caused me TONS of issues
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

  void _respawn() async {
    if (game.playSounds) FlameAudio.play('hit.wav', volume: game.soundVolume);
    const canMoveDuration = Duration(milliseconds: 400);
    gotHit = true;
    current = PlayerState.hit;

    // wait for the animation ticker,
    // once it's complete run the rest of the code
    await animationTicker?.completed;
    animationTicker?.reset();

    scale.x = 1;
    position = startingPosition - Vector2.all(32);
    current = PlayerState.appearing;

    await animationTicker?.completed;
    animationTicker?.reset();

    lifeCount--;
    print('Life Count: $lifeCount');



    if(lifeCount!= 0){velocity = Vector2.zero();
    position = startingPosition;
    _updatePlayerState();
    Future.delayed(canMoveDuration, () => gotHit = false);
    } else{
      //add death logic
    }
  }

  void _reachedCheckpoint() async {
    if (game.playSounds) {
      FlameAudio.play('disappear.wav', volume: game.soundVolume);
    }
    reachedCheckpoint = true;
    if (scale.x > 0) {
      position = position - Vector2.all(32);
    } else if (scale.x < 0) {
      position = position + Vector2(32, -32);
    }
    current = PlayerState.disappearing;

    await animationTicker?.completed;
    animationTicker?.reset();
    reachedCheckpoint = false;
    position = Vector2.all(-640);

    const waitToChangeDuration = Duration(seconds: 1);

    Future.delayed(waitToChangeDuration, () => game.loadNextLevel());
  }

  void collidedwithEnemy() {
    _respawn();
  }
}
