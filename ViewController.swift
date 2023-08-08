//
//  ViewController.swift
//  applepie3
//
//  Created by Hager on 04/08/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var correctWordLable: UILabel!
    
    
    
    var listOfWords = ["TREE", "APPLE", "GREEN", "BROWN", "LEAVES", "WOOD"]
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in buttons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLable.text = wordWithSpacing
        
        scoreLable.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        imageOutlet.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    
    
    

    @IBAction func pressedbuttons(_ sender: UIButton) {
        sender.isEnabled = false
           if let letterString = sender.title(for: .normal) {
               let letter = Character(letterString)
               // guesses the letter, and updates the game state.
               currentGame.playerGuessed(letter: letter)
               updateGameState()
           }
    }
}

