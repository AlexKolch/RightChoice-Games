//
//  GameFactory.swift
//  Right on target
//
//  Created by Алексей Колыченков on 23.08.2025.
//

import Foundation
/// Абстрактная фабрика - единая точка создания экземпляров класса Game
final class GameFactory {
    static func makeNumericGame(rounds: Int) -> some GameProtocol {
        // 1. Cоздание сущности "SecretValue"
        let minSecretValue = 0
        let maxSecretValue = 50
        let secretValue = SectretNumericValue(initialValue: 0) { _ in
            // реализация рандома для Int
            (minSecretValue...maxSecretValue).randomElement()!
        }
        // 2. Cоздание сущности "Game"
        return Game<SectretNumericValue>(secretValue: secretValue, roundsCount: rounds) { secretValue, userValue in
            // создаем логику сравнения и начисления очков
            var result: Int!
            if secretValue.value == userValue.value {
                result = maxSecretValue
            } else if secretValue.value > userValue.value {
                result = maxSecretValue - (secretValue.value - userValue.value)
            } else if secretValue.value < userValue.value {
                result = maxSecretValue - (userValue.value - secretValue.value)
            }
            return result
        }
    }
    
    static func makeColorGame(rounds: Int) -> some GameProtocol {
        // 1. Cоздание сущности "SecretValue"
        let initialSecretColor = Color()
        let secretValue = SecretColorValue(initialValue: initialSecretColor) { color in
            // реализация рандома для Color 
            var updatedColor = color
            updatedColor.red = (0...255).randomElement()!
            updatedColor.green = (0...255).randomElement()!
            updatedColor.blue = (0...255).randomElement()!
            return updatedColor
        }
        // 2. Cоздание сущности "Game"
        return Game<SecretColorValue>(secretValue: secretValue, roundsCount: rounds) { secretValue, userValue in
            secretValue.value == userValue.value ? 1 : 0 //логика сравнения и начисления очков
        }
    }
}
