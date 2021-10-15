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
    
    var totalWins = 0
    var totalLoses = 0

    // MARK: - Outlets:
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButton: [UIButton]!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Functions
    
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // «a player can't select a letter more than once in the same round»
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        // continue...
        
    }
    
    
    
    
}

