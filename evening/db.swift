//
//  db.swift
//  evening
//
//  Created by Milo Bello on 10/9/25.
//

import SQLite
import Foundation

func dbinit () -> Connection {
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
            } catch {
            }
        } catch {
            // hahass
        }
    } else {
        print("schema.sql not found")
    }
    
    return db
}

func addQuizSettoDB(quizSet: QuizSet, into db: Connection) throws {
    
    let loqs = Table("ListOfQuizSet")
    let id = Expression<String>("id")
    let name = Expression<String>("name")
    let descript = Expression<String>("descript")
    
    do {
        try db.run(loqs.insert(id <- quizSet.id.uuidString, name <- quizSet.name, descript <- quizSet.descript)
        )
    } catch {
        print("Insert failed: \(error)")
    }
}



func fetchloqs(db: Connection) throws -> [QuizSet] {
    let loqs = Table("ListOfQuizSet")
    let id = Expression<String>("id")
    let name = Expression<String>("name")
    let descript = Expression<String>("descript")
    
    var listOfSets: [QuizSet] = []
        for row in try db.prepare(loqs)
        {
            let uuids = UUID(uuidString: row[id])
            let quiz = QuizSet(id: uuids ?? UUID(), name: row[name], descript: row[descript])
            print(quiz.id)
            listOfSets.append(quiz)
        }
    return listOfSets
}
