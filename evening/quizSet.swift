//
//  quizSet.swift
//  evening
//
//  Created by Milo Bello on 9/21/25.
//

import Foundation

class QuizSet {
    
    var name: String = ""
    var cset: [Flashcard] = []
    var descript: String = ""
    
    func addFlashCard(card: Flashcard) {
        cset.append(card)
    }
    
    init(name: String, cset: [Flashcard]) {
        self.name = name
        self.cset = cset
    }
    
    init(name: String, cset: [Flashcard], descript: String) {
        self.name = name
        self.cset = cset
        self.descript = descript
    }
    
    init(name: String) {
        self.name = name
    }
}
