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
        var t1 = Flashcard(term: "apple", def: "a crunchy, red fruit")
        var t2 = Flashcard(term: "pear", def: "a crunchy, oddly-shaped fruit")
        
        var qs = QuizSet(name: "fruits")
        var qs2 = QuizSet(name: "vegetables")
      
        qs.addFlashCard(card: t1)
        qs.addFlashCard(card: t2)
        
        listOfSets.append(qs)
        listOfSets.append(qs2)
        
        return listOfSets
    }
}
