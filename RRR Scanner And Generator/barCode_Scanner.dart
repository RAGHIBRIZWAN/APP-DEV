import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class barCode_Scanner extends StatefulWidget {

  @override
  State<barCode_Scanner> createState() => _barCode_Scanner();
}

class _barCode_Scanner extends State<barCode_Scanner> {
  String? scanResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Barcode Scanner',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black87,
              ),
              icon: Icon(Icons.camera_alt_outlined),
              label: Text('Start Scan'),
              onPressed: scanBarcode,
            ),
            SizedBox(height: 20,),
            Text(scanResult == null? 'Scan a code!':'Scan Result: $scanResult',style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
    );
  }
  Future scanBarcode() async{
    String scanResult;
    try{
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
    }on PlatformException{
      scanResult = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      this.scanResult = scanResult;
    });
  }
}
