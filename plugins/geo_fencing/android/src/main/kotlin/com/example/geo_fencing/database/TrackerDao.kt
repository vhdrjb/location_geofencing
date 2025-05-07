package com.example.geo_fencing.database

class TrackerDao(appDatabase: AppDatabase) : Dao(appDatabase) {
    companion object {
        const val COLUMN_ID = "id"
        const val COLUMN_LOCATION_ID = "location_id"
        const val COLUMN_FROM = "start"
        const val COLUMN_TO = "end"
    }
}