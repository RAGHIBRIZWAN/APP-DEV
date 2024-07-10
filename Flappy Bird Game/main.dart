import 'package:chess/Screens/game_over.dart';
import 'package:chess/Screens/main_menu.dart';
import 'package:chess/flappy_bird.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:chess/assets.dart';

final game = FlappyBird();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameWidget(
            game: game,
            initialActiveOverlays: const [MainMenu.id],
            overlayBuilderMap: {
              MainMenu.id: (context, _) {
                return MainMenu(game: game);
              },
              GameOver.id: (context, _) {
                return GameOver(game: game);
              },
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'POWERED BY',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Image.asset('assets/images/RRR LOGO real.png'),
          ],
        ),
      ),
    );
  }
}
