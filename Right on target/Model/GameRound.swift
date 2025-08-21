//
//  GameRound.swift
//  Right on target
//
//  Created by Алексей Колыченков on 21.08.2025.
//

import Foundation

protocol GameRoundProtocol {
    // количество заработанных за раунд очков
    var roundScore: Int { get }
    // загаданное значение
    var currentSecretValue: Int { get }
    // подсчет заработанных за раунд очков
    func calculateScore(with value: Int)
}

class GameRound: GameRoundProtocol {
    var roundScore: Int = 0
    var currentSecretValue: Int = 0
    
    init(secretValue: Int) {
        currentSecretValue = secretValue
    }
    
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            roundScore += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            roundScore += 50 - currentSecretValue + value
        } else {
            roundScore += 50
        }
    }
}
