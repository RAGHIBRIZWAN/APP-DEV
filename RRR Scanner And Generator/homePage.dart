import 'package:barcode_scanner/barCode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scanner/qrCode.dart';
import 'package:barcode_scanner/qrcode_scanner.dart';
import 'package:barcode_scanner/barcode_scanner.dart';

class Intro extends StatefulWidget {

  @override
  State<Intro> createState() => _Intro();
}

class _Intro extends State<Intro> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('RRR Scanner And Generator',style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => barCode()),
                );
              },
              child: const Text('Barcode Generator'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => qrCode()),
                );
              },
              child: const Text('QrCode Generator'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              // style: ElevatedButton.styleFrom(backgroundColor: ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => barCode_Scanner()),
                );
              },
              child: const Text('Barcode Scanner'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => qrCode_Scanner()),
                );
              },
              child: const Text('QrCode Scanner'),
            ),
          ],
        ),
      ),
    );
  }
}
