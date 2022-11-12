import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
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
      
    GeneratedPluginRegistrant.register(with: self)
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
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
