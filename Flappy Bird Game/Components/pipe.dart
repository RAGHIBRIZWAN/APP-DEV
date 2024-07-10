import 'package:chess/configuration.dart';
import 'package:chess/flappy_bird.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:chess/pipe_position.dart';
import 'package:flame/flame.dart';
import 'package:chess/assets.dart';
import 'package:chess/Components/bird.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBird>{
  Pipe({
   required this.pipePosition,
   required this.height,
  });
  @override
  final double height;
  final PipePosition pipePosition;

  Future<void> onLoad() async{
    final up = await Flame.images.load(Assets.upPipe);
    final upWidth = up.width;
    final down = await Flame.images.load(Assets.downPipe);
    size = Vector2(50, height);

    double pipeWidth = 70;

    size = Vector2(pipeWidth, height);

    switch (pipePosition){
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(down);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - Configuration.groundHeight - Configuration.groundHeight - 20;
        sprite = Sprite(up);
        break;
    }

    add(RectangleHitbox());
  }
}
