import UIKit
import Flutter

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
      
      let fileApi = FileApiImpl()
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

      
      FileApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: fileApi)
      
      GeneratedPluginRegistrant.register(with: self)
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
}
