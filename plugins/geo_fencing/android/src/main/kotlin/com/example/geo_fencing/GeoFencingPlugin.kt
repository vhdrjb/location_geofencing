package com.example.geo_fencing

import android.content.Context
import com.example.geo_fencing.actions.result.FailureResult
import com.example.geo_fencing.actions.result.SuccessResult
import com.example.geo_fencing.factory.PluginMethodFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GeoFencingPlugin */
class GeoFencingPlugin : FlutterPlugin, MethodCallHandler {

    companion object {
        const val INIT_METHOD_NAME = "init_geo_fencing"
        const val INSERT_METHOD_NAME ="insert_location"
    }

    private lateinit var pluginMethodFactory: PluginMethodFactory
    private lateinit var channel: MethodChannel
    private var context: Context? = null
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ir.vhdrjb/geo_fencing")
        channel.setMethodCallHandler(this)
        pluginMethodFactory = PluginMethodFactory()
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (val methodResult = pluginMethodFactory.createMethodAction(call, context!!)) {
            is FailureResult -> {
                result.error(methodResult.error, null, null)
            }

            is SuccessResult -> {
                result.success(methodResult.result)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        context = null
    }
}
