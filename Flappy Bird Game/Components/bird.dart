import 'package:chess/assets.dart';
import 'package:chess/bird_movement.dart';
import 'package:chess/configuration.dart';
import 'package:chess/flappy_bird.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class Bird extends SpriteGroupComponent<BirdMovement> with HasGameRef<FlappyBird>,CollisionCallbacks{
  int score = 0;
  @override
  Future<void> onLoad() async{
    final mid = await gameRef.loadSprite(Assets.birdImage);
    final up = await gameRef.loadSprite(Assets.birdImage);
    final down = await gameRef.loadSprite(Assets.birdImage);

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y/4 - size.y/2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.middle:mid,
      BirdMovement.up:up,
      BirdMovement.down:down
    };
    add(CircleHitbox());
  }

  void fly(){
    add(
      MoveByEffect(Vector2(0,Configuration.gravity), EffectController(duration: 0.5,curve: Curves.decelerate),
      onComplete: ()=> current = BirdMovement.down,),
    );
    current = BirdMovement.up;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoint,
      PositionComponent other,
  ){
    super.onCollisionStart(intersectionPoint, other);
    gameOver();
  }

  void reset(){
    position = Vector2(50, gameRef.size.y/4 - size.y/2);
    score = 0;
  }

  void gameOver(){
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
    game.isHit = true;
  }

  @override
  void update(double dt){
    super.update(dt);
    position.y += Configuration.birdVelocity * dt;
  }
}
