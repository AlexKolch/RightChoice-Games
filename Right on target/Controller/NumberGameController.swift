//
//  ColorGameController.swift
//  Right on target
//
//  Created by Алексей Колыченков on 21.08.2025.
//

import UIKit

class NumberGameController: UIViewController {
  
    private var game: Game<SectretNumericValue>! // Сущность "Игра"
    
    // UI на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!

    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.makeNumericGame(rounds: 5) as! Game<SectretNumericValue>)
        // Обновляем данные о текущем значении загаданного числа
        updateLabel(with: game.secretValue.value)
    }
    
    // MARK: - Взаимодействие View - Model
    
    @IBAction func checkNumber() {
        // Высчитываем очки за раунд
        var userSecretValue = game.secretValue // получаем новый экземпляр SecretValue<Int>
        userSecretValue.value = Int(slider.value) // обновляем его значение новым из слайдера
        //сравниваем экземпляр загаданного значения с экземпляром с новым значением, уст пользователем
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        // Проверяем, окончена ли игра
       if game.isGameFinished {
           showAlert(with: game.totalScore)
           game.restartGame()
       } else {
           game.startNewRound()
       }
        updateLabel(with: game.secretValue.value)
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

