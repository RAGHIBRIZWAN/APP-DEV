import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class barCode extends StatefulWidget {
  @override
  State<barCode> createState() => _barCodeState();
}

class _barCodeState extends State<barCode> {
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
          'Enter data to generate a barcode',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        );
      }
      return BarcodeWidget(
        data: barcodeData,
        barcode: Barcode.code128(),
        width: 200,
        height: 200,
        drawText: false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Barcode Generator', style: TextStyle(color: Colors.white)),
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
                  child: const Text('Generate Barcode'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
