//
//  Game.swift
//  Right on target
//
//  Created by Алексей Колыченков on 20.08.2025.
//

import Foundation

protocol GameProtocol {
    associatedtype SecretType
    // Количество заработанных очков
    var totalScore: Int { get }
    // сюда установится сущность "Секретное значение" определяющая тип данных загаданного значения
    var secretValue: SecretType { get }
    // Проверяет, окончена ли игра
    var isGameFinished: Bool { get }
    // Начинает новую игру и сразу стартует первый раунд
    func restartGame()
    // Начинает новый раунд
    func startNewRound()
    // сравнение значения пользователя с загаданным и подсчет очков
    func calculateScore(secretValue: SecretType, userValue: SecretType)
}

class Game<T: SecretValueProtocol>: GameProtocol {
    typealias SecretType = T
    
    var totalScore: Int = 0
    
    var secretValue: T // секретное значение
    
    var isGameFinished: Bool {
        if currentRoundNumber == roundsCount {
            true
        } else {
            false
        }
    }
    
    private let roundsCount: Int
    private var currentRoundNumber: Int = 0
    // замыкание производит сравнение значений и возвращает заработанные очки
    private var compareValueClosure: (T, T) -> Int
    
    init(secretValue: T, roundsCount: Int, compareValueClosure: @escaping (T, T) -> Int) {
        self.secretValue = secretValue
        self.roundsCount = roundsCount
        // в замыкание передадим логику сравнения и начисления очков
        self.compareValueClosure = compareValueClosure
        startNewRound()
    }
    
    func restartGame() {
       totalScore = 0
        currentRoundNumber = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentRoundNumber += 1
        secretValue.setRandomValue()
    }
    
    func calculateScore(secretValue: T, userValue: T) {
        totalScore += compareValueClosure(secretValue, userValue)
    }
}
