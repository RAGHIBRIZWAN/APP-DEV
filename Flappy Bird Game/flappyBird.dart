import 'dart:ui';

import 'package:chess/Components/background.dart';
import 'package:chess/Components/bird.dart';
import 'package:chess/Components/ground.dart';
import 'package:chess/Components/pipe_group.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:chess/configuration.dart';
import 'package:flame/components.dart';


class FlappyBird extends FlameGame with TapDetector,HasCollisionDetection{
  late Bird bird;
  late TextComponent score;
  Timer interval = Timer(Configuration.pipeInterval,repeat: true);
  bool isHit = false;

  @override
  Future<void> onLoad() async{
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      PipeGroup(),
      score = buildScore(),
    ]);
    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore(){
    return TextComponent(
      text: 'Score = 0',
      position: Vector2(size.x / 2,size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextPaint.defaultTextStyle),
    );
  }

  @override
  void onTap(){
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt){
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';
  }
}
