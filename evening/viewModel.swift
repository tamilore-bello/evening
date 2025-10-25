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
    @Published var listOfSets: [QuizSet] = []
    @Published var listOfCard: [Flashcard] = []

    
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
    
    func refreshListOfCard(uuid: UUID) {
        let db = dbinit()
        do {
            print("fetching logs for refresh...")
            listOfCard = try fetchCards(db: db, uuid: uuid)
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
            refreshListOfCard(uuid: quiz.id)
        } catch {
            print("failure to add flashcard")
        }
    }
    
    func getCards(uuid: UUID) -> [Flashcard] {
        let db = dbinit()
        do {
            print("fetching flashcards...")
            return try fetchCards(db: db, uuid: uuid)
        } catch {
            print("failed to fetch flashcards")
        }
        return []
    }
}
