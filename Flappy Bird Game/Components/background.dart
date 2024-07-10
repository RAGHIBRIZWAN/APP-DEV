import 'package:chess/assets.dart';
import 'package:chess/flappy_bird.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBird>{
  Background();

  @override
  Future<void> onLoad() async{
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
