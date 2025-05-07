//Made by Vahid Rajabi

import Foundation

class TrackerDao:NSObject, Dao {
    static let COLUMN_ID = "id"
    static let COLUMN_LOCATION_ID = "location_id"
    static let COLUMN_FROM = "start"
    static let COLUMN_TO = "end"
    
    let database: AppDatabase
    
    init(database: AppDatabase) {
        self.database = database
    }
}
