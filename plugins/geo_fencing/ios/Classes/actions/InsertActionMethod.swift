//Made by Vahid Rajabi

import Foundation
import Flutter

class InsertMethodAction : MethodAction {
    static let LOCATION_NAME = "name"
    static let LOCATION_LATITUDE = "latitude"
    static let LOCATION_LONGITUDE = "longitude"
    
    func createAction(method: FlutterMethodCall) -> ActionResult {
        guard let args = method.arguments as? [String: Any],
              let name = args[InsertMethodAction.LOCATION_NAME] as? String,
              let latitude = args[InsertMethodAction.LOCATION_LATITUDE] as? Double,
              let longitude = args[InsertMethodAction.LOCATION_LONGITUDE] as? Double else {
            return FailureResult(error: "Invalid arguments")
        }
        
        let locationDao = LocationDao(database: AppDatabase.shared)
        
        do {
            try locationDao.insertItems(name: name, latitude: latitude, longitude: longitude)
            return SuccessResult()
        } catch {
            return FailureResult(error: error.localizedDescription)
        }
    }
    
    func hasValidArguments(method: FlutterMethodCall) -> Bool {
        return hasStringArgument(method: method, argument: InsertMethodAction.LOCATION_NAME) &&
               (method.arguments as? [String: Any])?[InsertMethodAction.LOCATION_LATITUDE] != nil &&
               (method.arguments as? [String: Any])?[InsertMethodAction.LOCATION_LONGITUDE] != nil
    }
}
