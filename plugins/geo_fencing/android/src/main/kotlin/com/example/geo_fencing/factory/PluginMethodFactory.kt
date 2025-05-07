package com.example.geo_fencing.factory

import android.content.Context
import com.example.geo_fencing.GeoFencingPlugin
import com.example.geo_fencing.actions.InitMethodAction
import com.example.geo_fencing.actions.InsertMethodAction
import com.example.geo_fencing.actions.MethodAction
import com.example.geo_fencing.actions.result.ActionResult
import io.flutter.plugin.common.MethodCall

class PluginMethodFactory {

    fun createMethodAction(method: MethodCall, context: Context): (ActionResult?) {
        val action: MethodAction = when (method.method) {
            GeoFencingPlugin.INIT_METHOD_NAME -> InitMethodAction(context)
            GeoFencingPlugin.INSERT_METHOD_NAME -> InsertMethodAction()
            else -> {
                return null
            }
        }
        return action.action(method)
    }
}