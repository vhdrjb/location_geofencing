//Made by Vahid Rajabi

import Flutter

class PluginMethodFactory {
    func createMethodAction(call: FlutterMethodCall) -> MethodAction? {
          switch call.method {
          case GeoFencingPlugin.INIT_METHOD_NAME:
              return InitMethodAction()
          case GeoFencingPlugin.INSERT_METHOD_NAME:
              return InsertMethodAction()
          default:
              return nil
          }
      }
}
