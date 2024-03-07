// check if player is overlapping an object
// do something
bool checkCollision(player, block) {
  final hitbox = player.hitbox;
  // get the information we need from
  // both player and block
  final playerX = player.position.x + hitbox.offsetX;
  final playerY = player.position.y + hitbox.offsetY;
  final playerWidth = hitbox.width;
  final playerHeight = hitbox.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  // set player's fixed x
  // so if the player is turned to the left
  final fixedX = player.scale.x < 0
      ? playerX - (hitbox.offsetX * 2) - playerWidth
      : playerX;

  // calculate the fixed X-coordinate of the player's hitbox,
  // adjust it based on the player's scale (direction). 

  final fixedY = block.isPlatform ? playerY + playerHeight : playerY;

  return (fixedY < blockY + blockHeight &&
      playerY + playerHeight > blockY &&
      fixedX < blockX + blockWidth &&
      fixedX + playerWidth > blockX);
}
