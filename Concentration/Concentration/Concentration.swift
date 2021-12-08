//
//  Concentration.swift
//  Concentration
//
//  Created by Linda adel on 11/28/21.
//

import Foundation
// Model contain the actual game logic , ui-indenpendent
class Concentration {
    var flipCount = 0
    var score = 0
    // game board
    var cards = [Card]()
    var cardHistory = [Int]()
    // Whether or not we have ONLY one card face-up
    var indexOfOneAndOnlyFaceUpCard: Int?
  
    func chooseCard (at index: Int){
        flipCount += 1
        // If we have a card facing up already, check if it matches the chosen one
        if !cards[index].isMatched {
            // If they match, marked them as matched
            if let matchIndex = indexOfOneAndOnlyFaceUpCard , matchIndex != index{
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    
                    score += 2
                }else {
                    if cardHistory.contains(index) || cardHistory.contains(matchIndex){
                        score -= 1
                    }
                }
                cards[index].isFacedUp = true
                cardHistory.append(index)
                cardHistory.append(matchIndex)
                // Since there was a card face-up already (and we selected a new one),we no longer have only 1 card face-up
                indexOfOneAndOnlyFaceUpCard = nil
            } else{
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFacedUp = false
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    // Build a Concentration game based on the given number of card-pairs
    init(numberOfPairsOfCard : Int) {
        // Create each card in the game
        for _ in 1...numberOfPairsOfCard {
            let card = Card()
            // append 2 cards because we have card and it's match, 2 cards have same identifier , same emoji
            //struct so we copy card value
            cards.append(card)
            cards.append(card)
        }
        // TODO: shuffle cards
        cards.shuffle()
    }
}
