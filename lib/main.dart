import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'signature_controller.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Signature Example',
      home: SignaturePage(),
    );
  }
}

class SignaturePage extends StatelessWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = Get.put(SignatureController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature example'),
        actions: [
          IconButton(
            onPressed: () {
              s.saveImage();
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShowSignaturePage()),
            ),
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: HandSignaturePainterView(
                control: s.control,
                type: SignatureDrawType.line,
                maxWidth: 3.0,
              ),
            ),
            CustomPaint(
              painter: DebugSignaturePainterCP(
                control: s.control,
                cp: false,
                cpStart: false,
                cpEnd: false,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => s.control.clear(),
        child: const Icon(Icons.delete_forever),
      ),
    );
  }
}

class ShowSignaturePage extends StatelessWidget {
  const ShowSignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = Get.put(SignatureController());
    Uint8List bytes = base64Decode(s.imageBase64.value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature'),
      ),
      body: Column(
        children: [
          Image.memory(bytes),
        ],
      ),
    );
  }
}
