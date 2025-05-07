package com.example.geo_fencing.actions

import com.example.geo_fencing.actions.result.ActionResult
import com.example.geo_fencing.actions.result.FailureResult
import io.flutter.plugin.common.MethodCall

interface MethodAction {


    fun createAction(method: MethodCall): ActionResult

    fun action(method: MethodCall): ActionResult {
        return if (hasValidArguments(method)) {
            createAction(method)
        } else {
            FailureResult("required arguments not set")
        }
    }

    fun hasValidArguments(method: MethodCall): Boolean {
        return true
    }

    fun hasStringArgument(method: MethodCall, argument: String): Boolean {
        return method.argument<String>(argument)?.isNotEmpty() == true
    }

}