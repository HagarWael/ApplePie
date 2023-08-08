//
//  Game.swift
//  applepie3
//
//  Created by Hager on 04/08/2023.
//

import Foundation
struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            if(incorrectMovesRemaining==0){
                print("no words anymore")
            }
            incorrectMovesRemaining -= 1
        }
    }
}


