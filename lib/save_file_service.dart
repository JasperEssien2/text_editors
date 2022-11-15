import 'dart:async';

import 'package:flutter/services.dart';

abstract class SaveFileService {
  FutureOr<bool> saveFile({required String fileName, required String text});
}

class MethodChannelService implements SaveFileService {
  static const _methodChannel =
      MethodChannel("com.example.text_editors/action");

  @override
  FutureOr<bool> saveFile(
      {required String fileName, required String text}) async {
    try {
      return await _methodChannel.invokeMethod(
        "createFile",
        {
          'fileName': fileName,
          'content': text,
        },
      );
    } catch (e) {
      return false;
    }
  }
}
