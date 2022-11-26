import Flutter
import PassKit
import UIKit

public class SwiftAddToWalletsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "add_to_wallets", binaryMessenger: registrar.messenger())
    let instance = SwiftAddToWalletsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "addToAppleWallet":
      // taken from https://github.com/barkibu/add_to_wallet
      let args = call.arguments as! [String: Any]
      let pass = args["pass"] as! FlutterStandardTypedData
      var newPass: PKPass
      do {
        newPass = try PKPass(data: pass.data)
      } catch {
        print("No valid Pass data passed")
        return
      }
      guard let addPassViewController = PKAddPassesViewController(pass: newPass) else {
        print("View controller messed up")
        return
      }

      guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
        print("Root VC unavailable")
        return
      }
      rootVC.present(addPassViewController, animated: true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
