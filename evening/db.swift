//
//  db.swift
//  evening
//
//  Created by Milo Bello on 10/9/25.
//

import SQLite
import Foundation

func dbinit () {
    let dbPath = try! FileManager
        .default
        .url(for: .documentDirectory,
             in: .userDomainMask,
             appropriateFor: nil,
             create: false)
        .appendingPathComponent("eveningdb.db")
        .path
    let db = try! Connection(dbPath)
    
    if let sqlFileURL = Bundle.main.url(forResource: "schema", withExtension: "sql") {
        do {
            let sql = try String(contentsOf: sqlFileURL, encoding: .utf8)
            do {
                try db.execute(sql)  // runs all statements in your .sql file
                print("hahaha")
            } catch {
            }
        } catch {
            // hahass
        }
    } else {
        print("schema.sql not found")
    }
}
