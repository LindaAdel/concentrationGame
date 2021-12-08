//
//  Card.swift
//  Concentration
//
//  Created by Linda adel on 11/28/21.
//

import Foundation
// Represents a "Card" that is used in the "Concentration" game
struct Card {
    
    var isFacedUp = false
    var isMatched = false
    
    /* A unique identifier for the card.
    (The pair of matching cards have the same identifier)*/
    var identifier : Int
    
    // Static identifier that is increased every time a new one is requested by getUniqueIdentifier()
    static var indentifierGenerator = 0
    
    // Create a card with the given identifier
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    // Returns a unique id to be used as a card identifier
    static func getUniqueIdentifier() -> Int {
        Card.indentifierGenerator += 1
        return Card.indentifierGenerator
    }
}
