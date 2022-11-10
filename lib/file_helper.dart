import 'package:text_editors/save_file_service.dart';

class FileHelper {
  FileHelper(this.service);

  final SaveFileService service;

  Future<bool> saveFile({required String fileName, required String text}) =>
      service.saveFile(fileName: fileName, text: text);
}
