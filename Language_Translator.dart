import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
          builder: (context) => MyHomePage(),
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
            Image.asset('assets/images/RRR LOGO.png'),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final outputController = TextEditingController();
  final translator = GoogleTranslator();

  String inputText = '';
  String inputLanguage = 'en';
  String outputLanguage = 'ur';

  Future<void> translateText() async {
    final translated = await translator.translate(inputText, from: inputLanguage, to: outputLanguage);
    setState(() {
      outputController.text = translated.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text('RRR Translator',style: TextStyle(fontSize: 25),)),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  maxLines: 5,
                  style: TextStyle(fontSize: 25,color: Colors.black87),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter text to translate',
                    hintStyle: TextStyle(color: Colors.black87)
                  ),
                  onChanged: (value) {
                    setState(() {
                      inputText = value;
                    });
                  },
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.orange,
                      ),
                      child: DropdownButton<String>(
                        style: TextStyle(fontSize: 25,color: Colors.black87),
                        value: inputLanguage,
                        onChanged: (newValue) {
                          setState(() {
                            inputLanguage = newValue!;
                          });
                        },
                        items: <String>[
                          'en', 'ur', 'fr', 'hi', 'es', 'de',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.orange,
                      ),
                      child: DropdownButton<String>(
                        style: TextStyle(fontSize: 25,color: Colors.black87),
                        value: outputLanguage,
                        onChanged: (newValue) {
                          setState(() {
                            outputLanguage = newValue!;
                          });
                        },
                        items: <String>[
                          'en', 'ur', 'fr', 'hi', 'es', 'de',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,foregroundColor: Colors.black87),
                  onPressed: translateText,
                  child: Text('Translate',style: TextStyle(fontSize: 20),),
                ),
                SizedBox(height: 16,),
                TextField(
                  controller: outputController,
                  maxLines: 5,
                  readOnly: true,
                  style: TextStyle(fontSize: 25,),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Result here...',
                    hintStyle: TextStyle(color: Colors.black87)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
