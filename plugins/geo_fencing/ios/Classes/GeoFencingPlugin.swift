import Flutter
import UIKit

public class GeoFencingPlugin: NSObject, FlutterPlugin {
    
  
    static let INIT_METHOD_NAME = "init_geo_fencing"
    static let INSERT_METHOD_NAME = "insert_location"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ir.vhdrjb/geo_fencing", binaryMessenger: registrar.messenger())
        let instance = GeoFencingPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let methodAction = PluginMethodFactory().createMethodAction(call: call) else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        let actionResult = methodAction.action(method: call)
        
        switch actionResult {
        case let successResult as SuccessResult:
            result(successResult.result)
        case let failureResult as FailureResult:
            result(FlutterError(code: failureResult.error, message: nil, details: nil))
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
