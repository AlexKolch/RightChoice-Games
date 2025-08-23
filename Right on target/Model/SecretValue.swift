//
// Сущность "Секретное значение"
// Будет использоваться в рамках класса Game как универсальный определитель загаданного значения

import Foundation

typealias SectretNumericValue = SecretValue<Int>
typealias SecretColorValue = SecretValue<Color>

/// Протокол, на основе которого будет создан тип, описывающий сущность "Секретное значение"
protocol SecretValueProtocol {
    // ассоциированный тип, который будет определять тип данных значения
    associatedtype ValueType
    // само загаданное значение
    var value: ValueType { get }
    // изменяет текущее значение на случайное значение
    mutating func setRandomValue()
}

struct SecretValue<T: Equatable>: SecretValueProtocol {
    typealias ValueType = T
   private(set) var value: T
    
    private let randomValueClosure: (T) -> T // Сюда будет иниц логика создания рандомного значения
    
    init(initialValue: T, randomValueClosure: @escaping (T) -> T) {
        self.value = initialValue
        self.randomValueClosure = randomValueClosure
    }
    
    mutating func setRandomValue() {
        self.value = randomValueClosure(self.value)
    }
}
