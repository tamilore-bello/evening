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
    let id = UUID()
    
    init(term: String, def: String) {
        self.term = term
        self.def = def
    }
}

