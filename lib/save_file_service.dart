import 'package:flutter/services.dart';
import 'package:text_editors/file_api.dart';

abstract class SaveFileService {
  Future<bool> saveFile({required String fileName, required String text});
}

class MethodChannelService implements SaveFileService {
  static const _methodChannel =
      MethodChannel("com.example.text_editors/action");

  @override
  Future<bool> saveFile(
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

class PigeonFileApiService implements SaveFileService {
  
  //TODO1: Initialise FileApi
  final _fileApi = FileApi();

  @override
  Future<bool> saveFile(
      {required String fileName, required String text}) async {
    try {
      final response = await _fileApi
          .saveTextFile(FileData(fileName: fileName, content: text));
      return response.successful!;
    } catch (e) {
      return false;
    }

    // TODO2: implement saveFile
    throw UnimplementedError();
  }
}
