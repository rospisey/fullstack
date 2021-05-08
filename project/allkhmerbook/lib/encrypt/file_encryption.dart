import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:allkhmerbook/file_process/get_directory.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileEncryption extends StatefulWidget {
  @override
  _FileEncryptionState createState() => _FileEncryptionState();
}

class _FileEncryptionState extends State<FileEncryption> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  static String externalPath(String filename) =>
      '/storage/emulated/0/Android/data/com.rospisey.allkhmerbook/files/Download/$filename';
  static String tempDir(String filename) =>
      '/data/user/0/com.rospisey.allkhmerbook/cache/$filename';

  static String? _encryption(String filename) {
    try {
      String path = externalPath('$filename');
      final filePath = _readData('$path');
      final encData = _encryptData(filePath);

      //_writeData you can directory to tempDir or ExternalDir
      String encPath = _writeData(encData, '$path.aes');
      File('$path').deleteSync();
      return encPath;
    } catch (e) {
      print('Error: $e');
    }
  }

  fileExist(String filename) {
    final f = File(externalPath(filename)).existsSync();
    if (!f) {
      _toggleLoading();
    }
    _toggleLoading();
  }

  static String? _decryption(String filename) {
    try {
      String path = externalPath(filename);
      final filePath = _readData('$path.aes');
      final decData = _decryptData(filePath);

      //_writeData you can directory to tempDir or ExternalDir
      String decPath = _writeData(decData, path);
      // File('$path.aes').deleteSync();
      return decPath;
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            TextButton(
                child:
                    _isLoading ? CircularProgressIndicator() : Text('Encrypt'),
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  compute(_encryption, 'video.mp4').then((value) {
                    setState(() {
                      _isLoading = false;
                      print(value);
                    });
                  });
                }),
            TextButton(
              child: _isLoading ? CircularProgressIndicator() : Text('Decrypt'),
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                compute(_decryption, 'video.mp4').then((value) {
                  setState(() {
                    _isLoading = false;
                  });
                  print(value);
                });
              },
            )
          ],
        ));
  }
}

Uint8List? _encryptData(plaintext) {
  try {
    final encrypted =
        MyEncrypt.myencrypt.encryptBytes(plaintext, iv: MyEncrypt.myiv);
    return encrypted.bytes;
  } catch (e) {
    print('Error: $e');
  }
}

_decryptData(encData) {
  enc.Encrypted en = new enc.Encrypted(encData);
  return MyEncrypt.myencrypt.decryptBytes(en, iv: MyEncrypt.myiv);
}

Uint8List? _readData(fileNameWithPath) {
  try {
    File f = File(fileNameWithPath);
    return f.readAsBytesSync();
  } catch (e) {
    print('Error: $e');
  }
}

String _writeData(dataToWrite, fileNameWithPath) {
  File f = File(fileNameWithPath);
  f.writeAsBytesSync(dataToWrite);
  return f.absolute.toString();
}

class MyEncrypt {
  static final mykey = enc.Key.fromUtf8('CBoaDQIQAgceGg8dFAkMDBEOECEZCxgM');
  static final myiv = enc.IV.fromUtf8('rospisey12345');
  static final myencrypt = enc.Encrypter(enc.AES(mykey));
}
