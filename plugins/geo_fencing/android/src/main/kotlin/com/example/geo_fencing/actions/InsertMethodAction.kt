package com.example.geo_fencing.actions

import com.example.geo_fencing.actions.result.ActionResult
import com.example.geo_fencing.actions.result.FailureResult
import com.example.geo_fencing.actions.result.SuccessResult
import com.example.geo_fencing.database.AppDatabase
import com.example.geo_fencing.database.LocationDao
import io.flutter.plugin.common.MethodCall

class InsertMethodAction : MethodAction {
    companion object {
        const val LOCATION_NAME = "name"
        const val LOCATION_LATITUDE = "latitude"
        const val LOCATION_LONGITUDE = "longitude"
    }

    override fun createAction(method: MethodCall): ActionResult {
        val locationDao = LocationDao(AppDatabase.getInstance())
        return try {
            locationDao.insertItems(
                method.argument<String>(LOCATION_NAME)!!,
                method.argument<Double>(LOCATION_LATITUDE)!!,
                method.argument<Double>(LOCATION_LONGITUDE)!!
            )
            SuccessResult()
        } catch (error: Throwable) {
            FailureResult(error.message ?: "insert location error")
        }
    }

    override fun hasValidArguments(method: MethodCall): Boolean {
        return hasStringArgument(method, LOCATION_NAME)
                &&
                method.hasArgument(LOCATION_LATITUDE)
                &&
                method.hasArgument(LOCATION_LONGITUDE)
    }
}