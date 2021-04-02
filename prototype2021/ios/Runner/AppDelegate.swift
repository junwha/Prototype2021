import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if (CLLocationManager.locationServicesEnabled()) {
    switch CLLocationManager.authorizationStatus() {
    case .denied, .notDetermined, .restricted:
        self.manager.requestAlwaysAuthorization()
        break
    default:
        break
    }
}
    //Google Map
    GMSServices.provideAPIKey("AIzaSyBhcuH45NaLJEqVuqGG7EmPqPPIJq9kumc")
    GeneratedPluginRegistrant.register(with: self)
  
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
  }
  
}
