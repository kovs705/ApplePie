//
//  ViewController.swift
//  ApplePie
//
//  Created by Kovs on 13.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    // a list of words for players to guess:
    var listOfWords = ["eugene", "dog", "paper", "character", "wallpaper", "sky", "tree", "house", "melon", "fire", "white", "black", "game", "bool", "bear", "cat", "moose", "dark", "light"]
    // how many incorrect guesses are allowed per round:
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

    // the game value:
    var currentGame: Game!
    
    // MARK: - Outlets:
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButton: [UIButton]!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    // MARK: - Functions
    
    func newRound() {
        let newWord = listOfWords.removeFirst() // removes and return the first element of the collection
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
        updateUI()
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // a player can't select a letter more than once in the same round
        sender.isEnabled = false
        // read the button's title, and determine if that letter is in the word the player is trying to guess:
        
        let letterString = sender.title(for: .normal)! // get the title of the button
        let letter = Character(letterString.lowercased()) // make it lowercased
        currentGame.playerGuessed(letter: letter)
        // updateUI()
        updateGameState()
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
    
    
    
    
}

