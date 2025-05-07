//Made by Vahid Rajabi

import Foundation
import SQLite3

class LocationDao: NSObject, Dao {
    static let COLUMN_ID = "id"
        static let COLUMN_NAME = "name"
        static let COLUMN_LATITUDE = "latitude"
        static let COLUMN_LONGITUDE = "longitude"
        
        let database: AppDatabase
        
        init(database: AppDatabase) {
            self.database = database
        }
        
        var table: String {
            guard let table = PluginParams.LOCATION_TABLE else {
                fatalError("Location table name not set")
            }
            return table
        }
        
        func insertItems(name: String, latitude: Double, longitude: Double) throws {
            let query = """
                INSERT INTO \(table) (\(LocationDao.COLUMN_NAME), \(LocationDao.COLUMN_LATITUDE), \(LocationDao.COLUMN_LONGITUDE))
                VALUES (?, ?, ?)
            """
            
            var statement: OpaquePointer?
            
            guard sqlite3_prepare_v2(database.database, query, -1, &statement, nil) == SQLITE_OK else {
                throw NSError(domain: "SQLiteError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to prepare statement"])
            }
            
            sqlite3_bind_text(statement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_double(statement, 2, latitude)
            sqlite3_bind_double(statement, 3, longitude)
            
            if sqlite3_step(statement) != SQLITE_DONE {
                sqlite3_finalize(statement)
                throw NSError(domain: "SQLiteError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to insert"])
            }
            
            sqlite3_finalize(statement)
        }
        
        func getAllItems() -> [LocationModel] {
            var items: [LocationModel] = []
            let query = "SELECT * FROM \(table)"
            var statement: OpaquePointer?
            
            guard sqlite3_prepare_v2(database.database, query, -1, &statement, nil) == SQLITE_OK else {
                return items
            }
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let namePtr = sqlite3_column_text(statement, 1)
                let name = String(cString: namePtr!)
                let latitude = sqlite3_column_double(statement, 2)
                let longitude = sqlite3_column_double(statement, 3)
                
                items.append(LocationModel(name: name, latitude: latitude, longitude: longitude))
            }
            
            sqlite3_finalize(statement)
            return items
        }
}
