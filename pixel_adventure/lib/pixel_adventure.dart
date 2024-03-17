import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:pixel_adventure/components/jump_button.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection, TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  

  late CameraComponent cam;
  // grab a player reference to use it in game
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  bool showControls = false;
  bool playSounds = true;
  double soundVolume = 1.0;
  List<String> levelNames = ['Level-01', 'Level-02'];
  int currentLevelIndex = 0;

  @override
  FutureOr<void> onLoad() async {
     // debugMode = true;

    // Load all images into cache
    await images.loadAllImages();

    // add camera and world to level
    _loadLevel();

    // Add joystick if needed
    if (showControls) {
      addJoyStick();
      add(JumpButton());
    }

    // Call super onLoad method and return its result
    return super.onLoad();
  }

  // PROBLEM THE BRACE WAS THE ISSUE super.update in wrong
  @override
  void update(double dt) {
    if (showControls) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoyStick() {
    joystick = JoystickComponent(
      priority: 100,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      knobRadius: 25,
      margin: const EdgeInsets.only(
        left: 32,
        bottom: 32,
      ),
    );
    add(joystick);
  }

  // create a method that changes
  // which direction the player is moving
  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    if (currentLevelIndex < levelNames.length - 1) {
      removeWhere((component) => component is Level);
      currentLevelIndex++;
      _loadLevel();
    } else {
      // no more levels
      removeWhere((component) => component is Level);
      currentLevelIndex = 0;
      _loadLevel();
    }
  }

  void _loadLevel() {
    Future.delayed(
        const Duration(seconds: 1,), () {
      // Create the world/level
      Level world = Level(
        player: player,
        levelName: levelNames[currentLevelIndex],
      );

      // Set up camera
      cam = CameraComponent.withFixedResolution(
        world: world,
        width: 575,
        height: 280,
      );
      cam.viewfinder.anchor = Anchor.topLeft;

      // Add camera and world to game
      addAll([cam, world]);
    });
  }
}
