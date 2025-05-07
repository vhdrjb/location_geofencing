package com.example.geo_fencing.database

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import com.example.geo_fencing.PluginParams

class AppDatabase private constructor(context: Context, databasePath: String, version: Int) :
    SQLiteOpenHelper(context, databasePath, null, version, null) {


    companion object {


        @Volatile
        private var INSTANCE: AppDatabase? = null

        fun getInstance(): AppDatabase {
            if (INSTANCE == null) {
                throw Exception("database not initialized. call init method first")
            }
            return INSTANCE!!
        }

        fun init(context: Context, databasePath: String, version: Int): AppDatabase {
            return INSTANCE ?: synchronized(this) {
                val dbPath = "${databasePath}/geo_fencing.db"
                INSTANCE ?: AppDatabase(context.applicationContext, dbPath, version)
                    .also { INSTANCE = it }
            }
        }
    }

    override fun onCreate(db: SQLiteDatabase?) {
        db?.execSQL(locationTableQuery)
        db?.execSQL(trackerTableQuery)
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {}

    private val locationTableQuery
        get() = """
            CREATE TABLE IF NOT EXISTS ${PluginParams.LOCATION_TABLE} (
                ${LocationDao.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${LocationDao.COLUMN_NAME} TEXT NOT NULL,
                ${LocationDao.COLUMN_LONGITUDE} NUMERIC DEFAULT 0.0,
                $${LocationDao.COLUMN_LATITUDE} NUMERIC DEFAULT 0.0
            )
        """.trimIndent()

    private val trackerTableQuery
        get() = """
            CREATE TABLE IF NOT EXISTS ${PluginParams.TRACKER_TABLE} (
                $${TrackerDao.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
                $${TrackerDao.COLUMN_LOCATION_ID} INTEGER NOT NULL,
                $${TrackerDao.COLUMN_FROM} timestamp DEFAULT CURRENT_TIMESTAMP,
                $${TrackerDao.COLUMN_TO} timestamp DEFAULT NULL
            )
        """.trimIndent()


}