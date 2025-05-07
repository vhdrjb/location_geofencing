//Made by Vahid Rajabi

import Foundation
import SQLite3

class AppDatabase {
    static let shared = AppDatabase()
    private var db: OpaquePointer?
    private var databaseInitialized = false
    
    private init() {}
    
    func initialize(path: String, version: Int) {
        let dbPath = "\(path)/geo_fencing.db"
        
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
            print("Error opening database")
            return
        }
        
        createTables()
        databaseInitialized = true
    }
    
    var database: OpaquePointer? {
        if !databaseInitialized {
            fatalError("Database not initialized. Call initialize method first.")
        }
        return db
    }
    
    private func createTables() {
        guard let locationTable = PluginParams.LOCATION_TABLE,
              let trackerTable = PluginParams.TRACKER_TABLE else {
            return
        }
        
        let locationTableQuery = """
            CREATE TABLE IF NOT EXISTS \(locationTable) (
                \(LocationDao.COLUMN_ID) INTEGER PRIMARY KEY AUTOINCREMENT,
                \(LocationDao.COLUMN_NAME) TEXT NOT NULL,
                \(LocationDao.COLUMN_LONGITUDE) NUMERIC DEFAULT 0.0,
                \(LocationDao.COLUMN_LATITUDE) NUMERIC DEFAULT 0.0
            )
        """
        
        let trackerTableQuery = """
            CREATE TABLE IF NOT EXISTS \(trackerTable) (
                \(TrackerDao.COLUMN_ID) INTEGER PRIMARY KEY AUTOINCREMENT,
                \(TrackerDao.COLUMN_LOCATION_ID) INTEGER NOT NULL,
                \(TrackerDao.COLUMN_FROM) TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                \(TrackerDao.COLUMN_TO) TIMESTAMP DEFAULT NULL
            )
        """
        
        executeQuery(query: locationTableQuery)
        executeQuery(query: trackerTableQuery)
    }
    
    func executeQuery(query: String) {
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error executing query: \(query)")
            }
        } else {
            print("Error preparing query: \(query)")
        }
        
        sqlite3_finalize(statement)
    }
    
    deinit {
        if db != nil {
            sqlite3_close(db)
        }
    }
}
