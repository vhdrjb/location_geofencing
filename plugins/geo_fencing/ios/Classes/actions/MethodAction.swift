//Made by Vahid Rajabi

import Flutter

protocol MethodAction {
    func createAction(method: FlutterMethodCall) -> ActionResult
    func action(method: FlutterMethodCall) -> ActionResult
    func hasValidArguments(method: FlutterMethodCall) -> Bool
}

extension MethodAction {
    func action(method: FlutterMethodCall) -> ActionResult {
            if hasValidArguments(method: method) {
                return createAction(method: method)
            } else {
                return FailureResult(error: "required arguments not set")
            }
        }
        
        func hasValidArguments(method: FlutterMethodCall) -> Bool {
            return true
        }
        
        func hasStringArgument(method: FlutterMethodCall, argument: String) -> Bool {
            guard let args = method.arguments as? [String: Any],
                  let arg = args[argument] as? String,
                  !arg.isEmpty else {
                return false
            }
            return true
        }
}
