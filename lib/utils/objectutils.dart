import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';



Image convertBase64toImage(String base64image, double maxSize) {
  const BASE64 = const Base64Codec();
  base64image = base64image.replaceAll("data:image/png;base64,", "");
  Uint8List bytes = BASE64.decode(base64image);
  return new Image.memory(bytes, fit: BoxFit.scaleDown, width: maxSize, height: maxSize);
}