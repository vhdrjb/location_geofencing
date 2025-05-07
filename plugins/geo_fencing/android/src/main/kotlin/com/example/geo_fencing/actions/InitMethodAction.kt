package com.example.geo_fencing.actions

import android.content.Context
import com.example.geo_fencing.PluginParams
import com.example.geo_fencing.actions.result.ActionResult
import com.example.geo_fencing.actions.result.SuccessResult
import com.example.geo_fencing.database.AppDatabase
import io.flutter.plugin.common.MethodCall

class InitMethodAction(private val context: Context) : MethodAction {

    companion object {
        private const val DATABASE_KEY = "database-path-key"
        private const val DATABASE_VERSION_KEY = "database-version-key"
        private const val TRACKER_DATABASE_NAME = "database-tracker-table"
        private const val LOCATION_DATABASE_NAME = "database-location-table"
    }

    override fun createAction(method: MethodCall): ActionResult {
        PluginParams.DATABASE_VERSION = method.argument(DATABASE_VERSION_KEY)

        initDatabase(method)

        PluginParams.LOCATION_TABLE = method.argument<String>(
            LOCATION_DATABASE_NAME
        )

        PluginParams.TRACKER_TABLE = method.argument<String>(
            TRACKER_DATABASE_NAME
        )

        return SuccessResult()
    }

    private fun initDatabase(method: MethodCall) {
        val dbLocation = method.argument<String>(DATABASE_KEY)
        val dbVersion = method.argument<Int>(DATABASE_VERSION_KEY)

        if (dbLocation?.isNotEmpty() == true) {
            AppDatabase.init(context, dbLocation, dbVersion!!)
        }
    }


    override fun hasValidArguments(method: MethodCall): Boolean {
        return method.hasArgument(DATABASE_KEY)
                &&
                method.hasArgument(DATABASE_VERSION_KEY)
                &&
                hasStringArgument(method, TRACKER_DATABASE_NAME)
                &&
                hasStringArgument(method, LOCATION_DATABASE_NAME)
    }

}