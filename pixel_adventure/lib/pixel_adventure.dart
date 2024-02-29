import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => Color(0xFF211F30);

  late final CameraComponent cam;
  // grab a player reference to use it in game
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  // IT HAS SOMETHING TO DO WITH JOYSTICK (false = no show)
  // PROBLEM
  bool showJoystick = false;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    // Create the world/level
    final world = Level(
      player: player,
      levelName: 'Level-01',
    );

    // Set up camera
    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    // Add camera and world to game
    addAll([cam, world]);

    // Add joystick if needed
    if (showJoystick) {
      addJoyStick();
    }

    // Call super onLoad method and return its result
    return super.onLoad();
  }

  // PROBLEM THE BRACE WAS THE ISSUE super.update in wrong
  @override
  void update(double dt) {
    if (showJoystick) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoyStick() {
    joystick = JoystickComponent(
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
}
