//
//  ViewController.swift
//  Concentration
//
//  Created by Linda adel on 11/25/21.
//

import UIKit

class ViewController: UIViewController {
    
    // create instance from model aka game logic
    // without lazy we have an error because the game is not fully initializerd yet and var game depend on another var cardButtons
    //lazy make game uninitisalized untill its used
    // Lazy allows us to use instance variable "cardButtons", because it should
    // be already initialized by the time a lazy var is used.'
    // lazy var game = Concentration(numberOfPairsOfCard: (cardButtons.count+1)/2)
    var game : Concentration!
    var theme : Theme!
    
    // didset is a property observer used for updating the label each time the count change instead of reapiting this line with each change
    //did set will change the value of label immiditly after flipping card while will set will change the flip label value to 1 after the second card is flipped
//    var flipCount = 0
//    {
//        didSet{
//            flipCountLabel.text = "Flips : \(flipCount)"
//        }
//
 //   }
  
    // This is the "database" of possible card options/images. For each card we encounter
    //that has no emoji set, we'll pick one from here (and delete it, to avoid duplicates)
    var themes : [Theme] =
        [ (Theme.init(name: "Halloween",
                      boardGameColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                      cardBackColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),
                      emoji: ["👻","🎃","🤡","💀","🦇","🕷","🕸","🦉","😱","👺","🧟‍♀️","🧛🏻‍♀️","⚰️","👽","🧙🏻‍","🧞‍","🧞","🧟‍","🧝🏼‍♂️","🧛🏻","🧛🏼‍♂️"])),
          (Theme.init(name: "sports",
                      boardGameColor: #colorLiteral(red: 0.3437698287, green: 0.1994298967, blue: 0.004423051189, alpha: 1),
                      cardBackColor: #colorLiteral(red: 0.00112117581, green: 0.3948526192, blue: 0.001739606352, alpha: 1),
                      emoji: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🪀","🏓","🏸","🏒","🏑","🥍","🏹","🥋","🛷","🛹","⛸","⛷","🏋️‍♂️","🏂","🪂","🏋🏼‍♀️","🧘🏼‍♀️","🏊🏼‍♂️","🚣🏼‍♀️"])),
          (Theme.init(name: "faces",
                      boardGameColor: #colorLiteral(red: 1, green: 0.492789764, blue: 0.09722168485, alpha: 1),
                      cardBackColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1),
                      emoji: ["😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😊","😇","🙂","😍","😌","😉","🙃","🥰","😘","😗","😙","😝","😛","😋","😚","😜","🤪","🤨","🧐"]))
        
    ]
//    var emojiChoices = ["👻","🎃","🤡","💀","🦇","🕷","🕸","🦉","😱","👺","🧟‍♀️","🧛🏻‍♀️","⚰️","👽","🧙🏻‍","🧞‍","🧞","🧟‍","🧝🏼‍♂️","🧛🏻","🧛🏼‍♂️"]
    //emoji dictionary has emoji for card id
    var emoji = [Int : String]()
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameSetUp()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else {
            print("not selected")
        }
    }
    func updateViewFromModel(){
        flipCountLabel.text = "Flips : \(game.flipCount)"
        scoreLabel.text = "score : \(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp{
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                // for uicontrol.state = normal indicate the normal state of the button , action done for normal we have other states that can have different settings
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? view.backgroundColor : theme.cardBackColor
            }
        }
        
        
    }
    
    @IBAction func newGameTapped(_ sender: UIButton) {
        gameSetUp()
    }
    func gameSetUp(){
        // Create new Concentration game
        game = Concentration(numberOfPairsOfCard: (cardButtons.count+1)/2)
        // get a game a random theme
        theme = themes[Int(arc4random_uniform(UInt32(themes.count)))]
        view.backgroundColor = theme.boardGameColor
        // Update cards view
        updateViewFromModel()
    }
    func emoji(for card: Card) -> String{
        var emojis = theme.emoji
        if emoji[card.identifier] == nil{
           // if emojiChoices.count > 0 {
          //  let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            if emojis.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
                // Add the random emoji to card and Remove it from emojiChoices so that it doesn't get selected again
              //  emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
                emoji[card.identifier] = emojis.remove(at: randomIndex)
            }

        }
       
        return emoji[card.identifier] ?? "?"
    }
    
}

