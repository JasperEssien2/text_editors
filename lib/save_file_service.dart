import 'dart:async';

import 'package:flutter/services.dart';

abstract class SaveFileService {
  FutureOr<bool> saveFile({required String fileName, required String text});
}

class MethodChannelService implements SaveFileService {
  //TODO1: Create a method channel

  @override
  FutureOr<bool> saveFile(
      {required String fileName, required String text}) async {
    //TODO2: Invoke a method, passing in neccessary arguments

    throw UnimplementedError();
  }
}
