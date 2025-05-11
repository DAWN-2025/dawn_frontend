import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    if let apiKey = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String {
        GMSServices.provideAPIKey(apiKey)
    } else {
        print("Error: Google Maps API Key not found in Info.plist")
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
