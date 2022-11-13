// Autogenerated from Pigeon (v4.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif


/// Generated class from Pigeon.

///Generated class from Pigeon that represents data sent in messages.
struct FileData {
  var fileName: String? = nil
  var content: String? = nil

  static func fromMap(_ map: [String: Any?]) -> FileData? {
    let fileName = map["fileName"] as? String 
    let content = map["content"] as? String 

    return FileData(
      fileName: fileName,
      content: content
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "fileName": fileName,
      "content": content
    ]
  }
}

///Generated class from Pigeon that represents data sent in messages.
struct Response {
  var successful: Bool? = nil
  var error: String? = nil

  static func fromMap(_ map: [String: Any?]) -> Response? {
    let successful = map["successful"] as? Bool 
    let error = map["error"] as? String 

    return Response(
      successful: successful,
      error: error
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "successful": successful,
      "error": error
    ]
  }
}
private class FileApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return FileData.fromMap(self.readValue() as! [String: Any])      
      case 129:
        return Response.fromMap(self.readValue() as! [String: Any])      
      default:
        return super.readValue(ofType: type)
      
    }
  }
}
private class FileApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? FileData {
      super.writeByte(128)
      super.writeValue(value.toMap())
    } else if let value = value as? Response {
      super.writeByte(129)
      super.writeValue(value.toMap())
    } else {
      super.writeValue(value)
    }
  }
}

private class FileApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return FileApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return FileApiCodecWriter(data: data)
  }
}

class FileApiCodec: FlutterStandardMessageCodec {
  static let shared = FileApiCodec(readerWriter: FileApiCodecReaderWriter())
}

///Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol FileApi {
  func saveTextFile(data: FileData) -> Response
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class FileApiSetup {
  /// The codec used by FileApi.
  static var codec: FlutterStandardMessageCodec { FileApiCodec.shared }
  /// Sets up an instance of `FileApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: FileApi?) {
    let saveTextFileChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.FileApi.saveTextFile", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      saveTextFileChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let dataArg = args[0] as! FileData
        let result = api.saveTextFile(data: dataArg)
        reply(wrapResult(result))
      }
    } else {
      saveTextFileChannel.setMessageHandler(nil)
    }
  }
}

private func wrapResult(_ result: Any?) -> [String: Any?] {
  return ["result": result]
}

private func wrapError(_ error: FlutterError) -> [String: Any?] {
  return [
    "error": [
      "code": error.code,
      "message": error.message,
      "details": error.details
    ]
  ]
}
