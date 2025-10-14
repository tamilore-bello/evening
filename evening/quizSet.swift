//
//  quizSet.swift
//  evening
//
//  Created by Milo Bello on 9/21/25.
//

import Foundation
internal import Combine

class QuizSet : ObservableObject, Identifiable {
    
    @Published var name: String = ""
    @Published var cset: [Flashcard] = []
    @Published var descript: String = ""
    
    @Published var id = UUID() // change to let later!!
    
    func addFlashCard(card: Flashcard) {
        cset.append(card)
    }
    
   
    init(id: UUID, name: String, descript: String) {
        //self.id = id.uuidString
        self.name = name
        self.descript = descript
    }
    init(name: String, cset: [Flashcard], descript: String) {
        self.name = name
        self.cset = cset
        self.descript = descript
    }
    
    init(name: String, cset: [Flashcard]) {
        self.name = name
        self.cset = cset
    }
    
    init(name: String, descript: String) {
        self.name = name
        self.descript = descript
    }
    
    init(name: String) {
        self.name = name
    }
}
