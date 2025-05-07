package com.example.geo_fencing.database

import android.content.ContentValues
import android.database.Cursor
import com.example.geo_fencing.PluginParams
import com.example.geo_fencing.model.LocationModel

class LocationDao(private val appDatabase: AppDatabase) :
    Dao(appDatabase) {

    companion object {
        // locations
        const val COLUMN_ID = "id"
        const val COLUMN_NAME = "name"
        const val COLUMN_LATITUDE = "latitude"
        const val COLUMN_LONGITUDE = "longitude"
    }

    private val table: String get() = PluginParams.LOCATION_TABLE!!

    fun insertItems(name: String, latitude: Double, longitude: Double) {
        val db = appDatabase.writableDatabase
        val values = ContentValues().apply {
            put(COLUMN_NAME, name)
            put(COLUMN_LATITUDE, latitude)
            put(COLUMN_LONGITUDE, longitude)
        }
        val id = db.insert(table, null, values)
        db.close()
    }

    fun getLocationById(id:Int) : LocationModel? {
        val db = appDatabase.readableDatabase
        val query = "select "
    }

    fun getAllItems(): List<LocationModel> {
        val itemList = mutableListOf<LocationModel>()
        val db = appDatabase.readableDatabase
        val query = "SELECT * FROM $table"
        val cursor: Cursor = db.rawQuery(query, null)

        if (cursor.moveToFirst()) {
            do {
                val id = cursor.getInt(cursor.getColumnIndexOrThrow(COLUMN_ID))
                val name = cursor.getString(cursor.getColumnIndexOrThrow(COLUMN_NAME))
                val latitude = cursor.getDouble(cursor.getColumnIndexOrThrow(COLUMN_LATITUDE))
                val longitude = cursor.getDouble(cursor.getColumnIndexOrThrow(COLUMN_LONGITUDE))

                val item =
                    LocationModel( name = name, latitude = latitude, longitude = longitude)
                itemList.add(item)
            } while (cursor.moveToNext())
        }

        cursor.close()
        db.close()
        return itemList
    }
}