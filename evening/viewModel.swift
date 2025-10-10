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
        return listOfSets
    }
    
    func execdb () {
        dbinit()
    }
//    func exec() -> [QuizSet] {
//        // intantiate the quiz set and terms
//        let t1 = Flashcard(term: "apple", def: "a crunchy, red fruit")
//        let t2 = Flashcard(term: "pear", def: "a crunchy, oddly-shaped fruit")
//        
//        let qs = QuizSet(name: "fruits")
//        let qs2 = QuizSet(name: "vegetables")
//      
//        qs.addFlashCard(card: t1)
//        qs.addFlashCard(card: t2)
//        
//        listOfSets.append(qs)
//        listOfSets.append(qs2)
//        for _ in 1...30 {
//            listOfSets.append(qs2)
//        }
//                
//        return listOfSets
//        
//        func addSet() {
//            
//        }
//    }
    
    func addSet(quiz: QuizSet) {
        listOfSets.append(quiz)
    }
}
