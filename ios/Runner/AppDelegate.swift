import UIKit
import Flutter

//TODO: 1. Implement the [FileApi] protocol
class FileApiImpl : FileApi{
    func saveTextFile(data: FileData) -> Response {
        let appSupportDir = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let filePath = appSupportDir.appendingPathComponent("\(data.fileName!).txt").path
        
        if(FileManager.default.createFile(atPath: filePath, contents: data.content!.data(using: .utf8))){
           return Response(successful: true)
        }else{
            return Response(successful: false, error: "Saving file failed")
        }
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      //TODO: 2. Delete method channel implementation between TODO 2 and TODO 3
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
      let channelName = "com.example.text_editors/action"
      let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)
      
      methodChannel.setMethodCallHandler({
          (call, result) -> () in
         
          guard call.method == "createFile" else{
              result(FlutterMethodNotImplemented)
                return
          }
          
          let arguments = call.arguments as! NSDictionary
          
          self.createTextFile(fileName: arguments["fileName"] as! String, fileContent: arguments["content"] as! String, result:result)
      })
      //TODO: 3.
    
      //TODO: 4. Initialize FileApiImpl
      let fileApi = FileApiImpl()
      
      //TODO: 5. Setup FileApi communication
      FileApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: fileApi)
      
    GeneratedPluginRegistrant.register(with: self)
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    //TODO: 6. Delete the createTextFile()
    private func createTextFile(fileName: String, fileContent: String, result: FlutterResult){
        
        let appSupportDir = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let filePath = appSupportDir.appendingPathComponent("\(fileName).txt").path
        
        if(FileManager.default.createFile(atPath: filePath, contents: fileContent.data(using: .utf8))){
            result(true)
        }else{
            
            result(FlutterError(code: "0", message: "Saving file failed", details: nil))
        }
    }
}
