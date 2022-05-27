import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';

class SignatureController extends GetxController {
  final HandSignatureControl control = HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );
  RxString imageBase64 = ''.obs;

  void saveImage() async {
    final image = await control.toImage(
      fit: true,
    );
    final rawData = image!.buffer.asUint8List();

    imageBase64.value = base64Encode(rawData);

    print(imageBase64.value);
  }
}
