//
//  ViewController.swift
//  Right on target
//
//  Created by Василий Усов on 
//

import UIKit

class NumberGameController: UIViewController {
  
    private var game: Game! // Сущность "Игра"
    
    // UI на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!

    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        let generator = RandomValueGenerator(minRangeValue: 1, maxRangeValue: 50)!
        game = Game(valueGenerator: generator, roundsCount: 3) // Создаем экземпляр сущности "Игра"
        // Обновляем данные о текущем значении загаданного числа
        updateLabel(with: game.currentRound.currentSecretValue)
    }
    
    // MARK: - Взаимодействие View - Model
    
    @IBAction func checkNumber() {
        // Высчитываем очки за раунд
        game.currentRound.calculateScore(with: Int(slider.value))
        // Проверяем, окончена ли игра
       if game.isGameFinished {
           showAlert(with: game.totalScore)
           game.restartGame()
       } else {
           game.startNewRound()
       }
        updateLabel(with: game.currentRound.currentSecretValue)
    }
    
    // MARK: - Обновление View
    // Обновляем данные о текущем значении загаданного числа
    private func updateLabel(with secretNumber: Int) {
        self.label.text = String(describing: secretNumber)
    }

    // Отображение всплывающего окна со счетом
    private func showAlert(with score: Int) {
        let alert = UIAlertController(
            title: "Игра окончена",
            message: "Вы заработали \(score) очков",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

