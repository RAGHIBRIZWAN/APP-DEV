import 'dart:math';

import 'package:chess/Components/pipe.dart';
import 'package:chess/configuration.dart';
import 'package:chess/flappy_bird.dart';
import 'package:chess/pipe_position.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBird>{
  PipeGroup();
  final _random = Random();
  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Configuration.groundHeight;
    final spacing = 130 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing);
    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY-spacing),
      Pipe(pipePosition: PipePosition.bottom, height:heightMinusGround - (centerY + spacing/2)),
    ]);
  }

  @override
  void update(double dt){
    super.update(dt);
    position.x -= Configuration.gameSpeed * dt;

    if(position.x < -10){
      removeFromParent();
      debugPrint('Removed');
      updateScore();
    }
    if(gameRef.isHit){
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore(){
    gameRef.bird.score += 1;
  }
}
