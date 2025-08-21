//
//  RandomGenerator.swift
//  Right on target
//
//  Created by Алексей Колыченков on 21.08.2025.
//

import Foundation

protocol GeneratorProtocol {
    func getRandomValue()->Int
}

class RandomValueGenerator: GeneratorProtocol {
    // Диапазон в котором выберется рандомное загаданное число
    private let minValue: Int
    private let maxValue: Int
    
    init?(minRangeValue: Int, maxRangeValue: Int) {
        guard minRangeValue <= maxRangeValue else { return nil }
        minValue = minRangeValue
        maxValue = maxRangeValue
    }
    
    func getRandomValue() -> Int {
        (minValue...maxValue).randomElement()!
    }
}
