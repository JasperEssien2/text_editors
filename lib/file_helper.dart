import 'dart:async';

import 'package:text_editors/save_file_service.dart';

class FileHelper {
  FileHelper(this.service);

  final SaveFileService service;

  FutureOr<bool> saveFile({required String fileName, required String text}) =>
      service.saveFile(fileName: fileName, text: text);
}
