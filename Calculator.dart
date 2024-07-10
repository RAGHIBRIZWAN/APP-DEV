import 'package:flutter/material.dart';
import 'dart:async';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}

class Splashscreen extends StatefulWidget {
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Calculator'),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                maxRadius: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset('assets/images/RRR transparent LOGO.png'),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        controller.text = '';
      } else if (value == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(controller.text);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          controller.text = eval.toString();
        } catch (e) {
          controller.text = 'Error';
        }
      } else {
        controller.text += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('RRR Calculator', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: TextField(
              controller: controller,
              readOnly: true,
              maxLines: 2,
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold, color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.025, color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.1,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                _buildButton('C'),
                _buildButton('('),
                _buildButton(')'),
                _buildButton('/'),
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('*'),
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('-'),
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('+'),
                _buildButton('00'),
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('='),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () => _buttonPressed(value),
      child: Text(value, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
    );
  }
}
