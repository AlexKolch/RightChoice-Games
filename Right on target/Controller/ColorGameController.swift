//
//  ColorGameController.swift
//  Right on target
//
//  Created by Алексей Колыченков on 21.08.2025.
//

import UIKit

class ColorGameController: UIViewController {
    
    private var game: Game<SecretColorValue>! // Сущность "Игра"
    private var correctButtonTag = 1
    @IBOutlet weak var HEXLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var buttonColor1: UIButton!
    @IBOutlet weak var buttonColor2: UIButton!
    @IBOutlet weak var buttonColor3: UIButton!
    @IBOutlet weak var buttonColor4: UIButton!
    // вспомогательное свойство, позволяющее работать с аутлетами кнопок, как с коллекцией
    var buttonsCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.makeColorGame(rounds: 5) as! Game<SecretColorValue>)
        buttonsCollection = [buttonColor1, buttonColor2, buttonColor3, buttonColor4]
        // Обновляем View
        updateScene()
    }
    
    private func updateScene() {
        updateScoreLabel(score: String(game.totalScore))
        let secretColorString = game.secretValue.value.getHexString()
        updateHEXLabel(with: secretColorString)
        updateButtons(with: game.secretValue)
    }

    // MARK: - Взаимодействие View - Model
    
    // Проверка выбранного пользователем цвета
    @IBAction func compareValue(_ sender: UIButton) {
        var userValue = game.secretValue
        userValue.value = Color(from: sender.backgroundColor!)
            game.calculateScore(secretValue: game.secretValue, userValue: userValue)
            
        if game.isGameFinished {
            showAlertWith(score: game.totalScore)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        updateScene()
    }
    
    // MARK: - Обновление View
    
    /// Обновление текста загаданного цвета
    private func updateHEXLabel(with newHEX: String) {
        HEXLabel.text = "#\(newHEX)"
    }
    
    private func updateScoreLabel(score: String) {
        scoreLabel.text = "Score: \(score)"
    }
    
    /// Установка фонового цвета кнопок
    private func updateButtons(with secretValue: SecretColorValue) {
        // определяем, какая кнопка будет правильной
        correctButtonTag = Int.random(in: 1...buttonsCollection.count)
        buttonsCollection.forEach { btn in
            // Для выбранной кнопки устанавливаем цвет как у загаданного значения
            if btn.tag == correctButtonTag {
                btn.backgroundColor = secretValue.value.getByUIColor()
            } else {
                // для остальных рандомные цвета
                var copySecretValue = secretValue //копируем экз. секретного значения
                copySecretValue.setRandomValue() //меняем цвет
                btn.backgroundColor = copySecretValue.value.getByUIColor()
            }
        }
    }
    
    private func showAlertWith(score: Int) {
        let alertController = UIAlertController(title: "Игра окончена!", message: "Ваш счет: \(score)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Начать заново", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
