import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class qrCode extends StatefulWidget {
  @override
  State<qrCode> createState() => _qrCode();
}

class _qrCode extends State<qrCode> {
  final controller = TextEditingController();
  String barcodeData = '';

  @override
  Widget build(BuildContext context) {
    Widget buildTextField(BuildContext context) => TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      decoration: InputDecoration(
        hintText: 'Enter the data',
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
      ),
    );

    Widget buildBarcode() {
      if (barcodeData.isEmpty) {
        return const Text(
          'Enter data to generate a QR code',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        );
      }
      return BarcodeWidget(
        data: barcodeData,
        barcode: Barcode.qrCode(),
        width: 200,
        height: 200,
        drawText: false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  color: Colors.white,
                  elevation: 6,
                  shadowColor: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: buildBarcode(),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: buildTextField(context),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      barcodeData = controller.text;
                      controller.clear();
                    });
                  },
                  child: const Text('Generate QR Code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
