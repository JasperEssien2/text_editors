import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:text_editors/file_api.dart';

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

class PigeonFileApiService implements SaveFileService {
  final _fileApi = FileApi();

  @override
  FutureOr<bool> saveFile(
      {required String fileName, required String text}) async {
    try {
      final response = await _fileApi
          .saveTextFile(FileData(fileName: fileName, content: text));
      return response.successful!;
    } catch (e) {
      return false;
    }
  }
}

typedef CreateFileDart = bool Function(
    ffi.Pointer<Utf8> fileName, ffi.Pointer<Utf8> content);

typedef CreateFileNative = ffi.Bool Function(
    ffi.Pointer<Utf8> fileName, ffi.Pointer<Utf8> content);


class FFIFileApiService implements SaveFileService {
  @override
  FutureOr<bool> saveFile({required String fileName, required String text}) {
    final ffi.DynamicLibrary nativeCreateFile =
        ffi.DynamicLibrary.open("file_api.dylib");

    final createTextFileFunction = nativeCreateFile
        .lookupFunction<CreateFileNative, CreateFileDart>("createTextFile");

    final fileNameUtf8 = fileName.toNativeUtf8();
    final contentUtf8 = text.toNativeUtf8();

    final bool successful = createTextFileFunction(fileNameUtf8, contentUtf8);

    malloc.free(fileNameUtf8);
    malloc.free(contentUtf8);

    return successful;
  }
}
