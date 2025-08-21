//
//  Game.swift
//  Right on target
//
//  Created by Алексей Колыченков on 20.08.2025.
//

import Foundation

protocol GameProtocol {
    var totalScore: Int { get }
    var secretValueGenerator: GeneratorProtocol { get }
    var currentRound: GameRoundProtocol! { get }
    var isGameFinished: Bool { get }
    func restartGame()
    func startNewRound()
}

class Game: GameProtocol {
    
    var totalScore: Int {
        var score: Int = 0
        for round in allRounds {
            score += round.roundScore
        }
        return score
    }
    
    var secretValueGenerator: any GeneratorProtocol
    var currentRound: (any GameRoundProtocol)!
  
    var isGameFinished: Bool {
        if allRounds.count == roundsCount {
            true
        } else {
            false
        }
    }
    
    private var allRounds = [GameRoundProtocol]()
    private let roundsCount: Int
    
    init(valueGenerator: GeneratorProtocol, roundsCount: Int) {
        self.secretValueGenerator = valueGenerator
        self.roundsCount = roundsCount
        startNewRound()
    }
   
    
    func restartGame() {
        allRounds.removeAll()
        startNewRound()
    }
    
    func startNewRound() {
        let newSecretValue = secretValueGenerator.getRandomValue()
        currentRound = GameRound(secretValue: newSecretValue)
        self.allRounds.append(currentRound)
    }
    

}
