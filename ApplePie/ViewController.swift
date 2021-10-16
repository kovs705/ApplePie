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
    
    var score = 0 {
        didSet {
            newRound()
        }
    }
    
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
    
    @IBOutlet weak var scoreBar: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    // MARK: - Functions
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst() // delete first/next word in array of words
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [], score: score)
            enableLetterButtons(true) // while there are words in the array, buttons will be enabled
            updateUI()
        } else {
            enableLetterButtons(false) // disable buttons to prevent from crashing
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        // enable or disable the collection of buttons by looping through them
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    // MARK: - updating the game
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpacing
        if score == 0 {
            scoreBar.text = "Your score is zero"
        } else {
            scoreBar.text = "Your score is: \(score)"
        }
        
        scoreLabel.text = "Wins: \(totalWins), losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    // MARK: - Button
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
    // MARK: - Update the game
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            score -= 10
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            score += 10
        } else {
            updateUI()
        }
    }
    
    
    
    
}

