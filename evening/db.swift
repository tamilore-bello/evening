//
//  db.swift
//  evening
//
//  Created by Milo Bello on 10/9/25.
//

import SQLite
import Foundation

// initialize database!
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

// adds a quiz set to the user's list of quiz sets.
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

// fetches all the user's quiz sets.
func fetchloqs(db: Connection) throws -> [QuizSet] {
    let loqs = Table("ListOfQuizSet")
    let id = Expression<String>("id")
    let name = Expression<String>("name")
    let descript = Expression<String>("descript")
    
    var listOfSets: [QuizSet] = []
        for row in try db.prepare(loqs)
        {
            let uuids = UUID(uuidString: row[id])
            let quiz = QuizSet(id: uuids!, name: row[name], descript: row[descript])
                listOfSets.append(quiz)
        }
    return listOfSets
}

// fetches all cards matching a particular parent ID
func fetchCards(db: Connection, uuid: UUID) throws -> [Flashcard] {
    let loqs = Table("ListOfFlashcard")
    let id = Expression<String>("id")
    let term = Expression<String>("term")
    let def = Expression<String>("def")
    let parent_id = Expression<String>("parent_id")
    
    var listOfFlashcard: [Flashcard] = []
        for row in try db.prepare(loqs)
        {
            if row[parent_id] == uuid.uuidString {
                listOfFlashcard.append(Flashcard(id: UUID(uuidString: row[id])!, term: row[term], def: row[def]))
            }
        }
    return listOfFlashcard
}

// adds a flashcard to the table of all flashcards
func addFCtoDB(quizSet: QuizSet, flashcard: Flashcard, into db: Connection) throws {
    
    let loqs = Table("ListOfFlashcard")
    let id = Expression<String>("id")
    let term = Expression<String>("term")
    let def = Expression<String>("def")
    let parent = Expression<String>("parent_id")
    
    do {
        try db.run(loqs.insert(id <- flashcard.id.uuidString, term <- flashcard.term, def <- flashcard.def, parent <- quizSet.id.uuidString)
        )
    } catch {
        print("Insert failed: \(error)")
    }
}

// prints all the current cards, regardless of set!
func printAllCards(db: Connection) throws {
    print("started process")
    let loqs = Table("ListOfFlashcard")
    let id = Expression<String>("id")
    let term = Expression<String>("term")
    let def = Expression<String>("def")
    let parent = Expression<String>("parent_id")
    
    for row in try db.prepare(loqs)
    {
       try print(row.get(id), row.get(term), row.get(def), row.get(parent))
    }
    print()
}

