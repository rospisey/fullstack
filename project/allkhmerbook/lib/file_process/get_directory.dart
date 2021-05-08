import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as p;

Future<String> findLocalPath() async {
  final directory = Platform.isAndroid
      ? await (p.getExternalStorageDirectory())
      : await p.getApplicationDocumentsDirectory();
  return directory!.path;
}
