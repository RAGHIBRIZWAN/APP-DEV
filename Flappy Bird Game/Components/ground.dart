import 'package:chess/configuration.dart';
import 'package:chess/flappy_bird.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:chess/assets.dart';
import 'package:flame/parallax.dart';

class Ground extends ParallaxComponent<FlappyBird> with HasGameRef<FlappyBird>{
  @override
  Future<void> onLoad() async{
    final ground = await Flame.images.load(Assets.ground);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground,fill: LayerFill.none),
      ),
    ]);
    add(RectangleHitbox(
      position: Vector2(0,gameRef.size.y - Configuration.groundHeight - Configuration.groundHeight),
      size: Vector2(gameRef.size.x,Configuration.groundHeight),
    ),);
  }
  @override
  void update(double dt){
    super.update(dt);
    parallax?.baseVelocity.x = Configuration.gameSpeed;
  }
}
