import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      //TODO1: Get access to the FlutterViewController
     
      let channelName = "com.example.text_editors/action"

      //TODO2: Create a method channel
    
      //TODO3: Set a method call handler
      
    GeneratedPluginRegistrant.register(with: self)
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func createTextFile(fileName: String, fileContent: String, result: FlutterResult){
        
        let appSupportDir = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let filePath = appSupportDir.appendingPathComponent("\(fileName).txt").path
        
        if(FileManager.default.createFile(atPath: filePath, contents: fileContent.data(using: .utf8))){
            //TODO4: Send back a success
        }else{
            //TODO5: Send back a FlutterError if saving failed
        }
    }
}
