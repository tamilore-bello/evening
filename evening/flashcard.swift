//
//  flashcard.swift
//  evening
//
//  Created by Milo Bello on 9/21/25.
//

import Foundation

class Flashcard: Identifiable {
    var term: String
    var def: String
    var id = UUID()
    
    init(id: UUID, term: String, def: String) {
        self.id = id
        self.term = term
        self.def = def
    }
    
    init(term: String, def: String) {
        self.term = term
        self.def = def
    }
}

