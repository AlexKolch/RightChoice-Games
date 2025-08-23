//
//  Color.swift
//  Right on target
//
//  Created by Алексей Колыченков on 21.08.2025.
// Свой кастомный тип Color

import UIKit

protocol ColorProtocol {
    // каналы цветов
    var red: UInt8 { get set }
    var green: UInt8 { get set }
    var blue: UInt8 { get set }
    /// создание цвета на основе UIColor
    init(from: UIColor)
    /// получение цвета в виде HEX-строки
    func getHexString() -> String
    /// получение цвета в виде UIColor для отображения на сцене
    func getByUIColor() -> UIColor
}

class Color: ColorProtocol, Equatable {
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    
    ///получить дефолтный цвет
    init() {
           red = 0
           green = 0
           blue = 0
       }
    
    required init(from color: UIColor) {
        //получаем данные о каждом канале хранящиеся в UIColor
        self.red = UInt8(color.cgColor.components![0] * CGFloat(255))
        self.green = UInt8(color.cgColor.components![1] * CGFloat(255))
        self.blue = UInt8(color.cgColor.components![2] * CGFloat(255))
    }
    
    // Получаем данные о цвете в виде String
    func getHexString() -> String {
        // Переводим данные об интенсивности каналов в 16-тиричную систему счисления
        // Для этого используем встроенный в тип String инициализатор
        //  позволяющий изменить систему счисления переданного числового значения
        var redPart = String(red, radix: 16, uppercase: true)
        if red <= 16 {
            redPart = "0\(redPart)"
        }
        var greenPart = String(green, radix: 16, uppercase: true)
        if green <= 16 {
            greenPart = "0\(greenPart)"
        }
        var bluePart = String(blue, radix: 16, uppercase: true)
        if blue <= 16 {
            bluePart = "0\(bluePart)"
        }
        
        return "\(redPart)\(greenPart)\(bluePart)"
    }
    
    func getByUIColor() -> UIColor {
        // Для создания значения типа UIColor для всех трех каналов необходимо передать значения типа CGFloat
        //  где каждое значение может меняться в диапазоне от 0.0 (минимальная интенсивность канала) до 1.0 (максимальная интенсивность канала)
        // Исходя из этого нам необходимо преобразовать имеющиеся значения от 0 до 255 в значения от 0.0 до 1.0
        //  где 0 соответствует 0.0, а 255 соответствует 1.0
        let redFloat = Float(red) / 255
        let greenFloat = Float(green) / 255
        let blueFloat = Float(blue) / 255
        return UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue: CGFloat(blueFloat), alpha: 1)
    }
    
    static func == (lhs: Color, rhs: Color) -> Bool {
        lhs.red == rhs.red && lhs.green == rhs.green && lhs.blue == rhs.blue
    }
}
