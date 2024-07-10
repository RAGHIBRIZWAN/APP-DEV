
import 'package:chess/flappy_bird.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final FlappyBird game;
  static const String id = 'gameOver';
  const GameOver({super.key,required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: ${game.bird.score}',
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20,),
            Image.asset('assets/images/gameOver.png'),
            ElevatedButton(onPressed: onRestart,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text('Restart',style: TextStyle(fontSize: 20),))
          ],
        ),
      ),
    );
  }
  void onRestart(){
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
