//
//  GameViewController.swift
//  Tag
//
//  Created by Дмитрий Кремлев on 13.07.2023.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var numberButtons: [UIButton]!
    lazy var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.start()
        setButtonsState()
    }
    
    @IBAction func NumberButtonClick(_ sender: UIButton) {
        
        guard numberButtons.contains(sender) else { return }
        
        game.click(index: sender.tag)
        setButtonsState()
        if game.checkWin() { showWin() }
    }
    
    
    private func setButtonState(_ button: UIButton, number: Int?) {
        
        if let number = number {
            UIView.animate(withDuration: 0.3) {
                button.alpha = 1
            }
            
            button.isEnabled = true
            button.setTitle(String(number), for: .normal)
        } else {
            UIView.animate(withDuration: 0.3) {
                button.alpha = 0
            }
            
            button.isEnabled = false
        }
    }
    
    private func setButtonsState() {
        for index in numberButtons.indices {
            setButtonState(numberButtons[index], number : game.numbers[index])
        }
    }
    
    private func showWin() {
        let alert = UIAlertController(title: "You won!!", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            self.game.start()
            self.setButtonsState()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
