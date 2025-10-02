//
//  viewModel.swift
//  menu
//
//  Created by Milo Bello on 9/17/25.
//

import Foundation
import SwiftUI
internal import Combine

class viewModel: ObservableObject {
    @Published var message = "Hello, Single ViewModel!"
    func getText() -> String {
        return "So this is going to be an awesome menu app."
    }
    
    func exec() -> [QuizSet] {
        // intantiate the quiz set and terms
        var listOfSets: [QuizSet] = []
        let t1 = Flashcard(term: "apple", def: "a crunchy, red fruit")
        let t2 = Flashcard(term: "pear", def: "a crunchy, oddly-shaped fruit")
        
        let qs = QuizSet(name: "fruits")
        let qs2 = QuizSet(name: "vegetables")
      
        qs.addFlashCard(card: t1)
        qs.addFlashCard(card: t2)
        
        listOfSets.append(qs)
        listOfSets.append(qs2)
        for _ in 1...30 {
            listOfSets.append(qs2)
        }
                
        return listOfSets
    }
}
