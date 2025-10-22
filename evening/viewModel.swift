//
//  viewModel.swift
//  menu
//
//  Created by Milo Bello on 9/17/25.
//

import Foundation
import SwiftUI
internal import Combine

class QuizSetListViewModel: ObservableObject {
    @Published var message = "Hello, Single ViewModel!"
    @Published var listOfSets: [QuizSet] = []
    
    func getSets() -> [QuizSet] {
        let db = dbinit()
        do {
            print("fetching logs...")
            refreshListOfSets()
            return try fetchloqs(db: db)
        } catch {
            print("failed to fetch list of quiz sets")
            return []
        }
        
    }
    
    func refreshListOfSets() {
        let db = dbinit()
        do {
            print("fetching logs for refresh...")
            listOfSets = try fetchloqs(db: db)
        } catch {
            print("failed to refresh list of quiz sets")
        }
    }
    

    func addSet(quiz: QuizSet) {
        // listOfSets.append(quiz)
        let db = dbinit()
        do {
            print("adding quizSets...")
            try addQuizSettoDB(quizSet: quiz, into: db)
            refreshListOfSets()
        } catch {
            print("failure to add quizSet")
        }
    }
    
    func addFlashcard(quiz: QuizSet, flashcard: Flashcard) {
        let db = dbinit()
        do {
            print("adding flashcard")
            try addFCtoDB(quizSet: quiz, flashcard: flashcard, into: db)        
        } catch {
            print("failure to add flashcard")
        }
    }
}
