import UIKit
import Flutter

class FileApiImpl : FileApi{
    func saveTextFile(data: FileData) -> Response {
    
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            let fileURL = dir.appendingPathComponent("\(data.fileName!).txt")
            
            do{
                try data.content!.write(to: fileURL, atomically: false, encoding: .utf8)
                return Response(successful: true)
            }catch{
                return Response(successful: false, error: "Saving file failed")
            }
        }

        return Response(successful: false, error: "Saving file failed")
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
