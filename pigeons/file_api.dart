import 'package:pigeon/pigeon.dart';

class FileData {
  String? fileName;
  String? content;
}

class Response {
  bool? successful;
  String? error;
}

@HostApi()
abstract class FileApi {
  Response saveTextFile(FileData data);
}
