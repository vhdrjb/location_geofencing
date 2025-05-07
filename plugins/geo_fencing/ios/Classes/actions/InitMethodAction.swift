//Made by Vahid Rajabi

import Flutter

class InitMethodAction: MethodAction {
    private static let DATABASE_KEY = "database-path-key"
    private static let DATABASE_VERSION_KEY = "database-version-key"
    private static let TRACKER_DATABASE_NAME = "database-tracker-table"
    private static let LOCATION_DATABASE_NAME = "database-location-table"
    
    func createAction(method: FlutterMethodCall) -> ActionResult {
        guard let args = method.arguments as? [String: Any] else {
            return FailureResult(error: "Invalid arguments")
        }
        
        if let dbVersion = args[InitMethodAction.DATABASE_VERSION_KEY] as? Int {
            PluginParams.DATABASE_VERSION = dbVersion
        }
        
        initDatabase(method: method)
        
        PluginParams.LOCATION_TABLE = args[InitMethodAction.LOCATION_DATABASE_NAME] as? String
        PluginParams.TRACKER_TABLE = args[InitMethodAction.TRACKER_DATABASE_NAME] as? String
        
        return SuccessResult()
    }
    
    private func initDatabase(method: FlutterMethodCall) {
        guard let args = method.arguments as? [String: Any],
              let dbLocation = args[InitMethodAction.DATABASE_KEY] as? String,
              let dbVersion = args[InitMethodAction.DATABASE_VERSION_KEY] as? Int else {
            return
        }
        
        if !dbLocation.isEmpty {
            AppDatabase.shared.initialize(path: dbLocation, version: dbVersion)
        }
    }
    
    func hasValidArguments(method: FlutterMethodCall) -> Bool {
        guard let args = method.arguments as? [String: Any] else {
            return false
        }
        
        return args[InitMethodAction.DATABASE_KEY] != nil &&
               args[InitMethodAction.DATABASE_VERSION_KEY] != nil &&
               hasStringArgument(method: method, argument: InitMethodAction.TRACKER_DATABASE_NAME) &&
               hasStringArgument(method: method, argument: InitMethodAction.LOCATION_DATABASE_NAME)
    }
}
