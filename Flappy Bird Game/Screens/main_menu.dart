import 'package:chess/flappy_bird.dart';
import 'package:flutter/material.dart';
import 'package:chess/assets.dart';

class MainMenu extends StatelessWidget {
  final FlappyBird game;
  static const String id = 'mainMenu';
  const MainMenu({Key? key, required this.game}):super(key: key);

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          game.overlays.remove('mainMenu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset('assets/images/menu.png'),
        ),
      ),
    );
  }
}
