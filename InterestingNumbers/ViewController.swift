//
//  ViewController.swift
//  InterestingNumbers
//
//  Created by Данік on 30/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let mainScreen = MainScreen()
    var rangeFrom = 0
    var rangeTo = 0
    let collectionView = YourViewController()
    
    
    override func loadView() {
        mainScreen.delegate = self
        view = mainScreen
        mainScreen.textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up button actions
    }
    
    private func handleButtonTapped(_ button: UIButton) {
            // Perform actions based on the tapped button
            if button == mainScreen.userNumberButton {
                // Handle userNumberButton tapped
                handleUserNumberButtonTapped()
            } else if button == mainScreen.randomNumberButton {
                // Handle randomNumberButton tapped
                handleRandomNumberButtonTapped()
            } else if button == mainScreen.numberInRangeButton {
                // Handle numberInRangeButton tapped
                handleNumberInRangeButtonTapped()
            } else if button == mainScreen.multipleNumbersButton {
                // Handle multipleNumbersButton tapped
                handleMultipleNumbersButtonTapped()
            } else if button == mainScreen.displayFactButton {
                handleDisplayFactButtonTapped()
            }
        }

        private func handleUserNumberButtonTapped() {
            clearTheTextField()
        }

        private func handleRandomNumberButtonTapped() {
            // Add your specific functionality for randomNumberButton tapped
            mainScreen.textField.text = "\(Int.random(in: 0...1000))"
        }

        private func handleNumberInRangeButtonTapped() {
            // Add your specific functionality for numberInRangeButton tapped
            let alert = UIAlertController(title: "Provide two numbers for the range", message: "", preferredStyle: .alert)

            alert.addTextField { (textField) in
                textField.placeholder = "From"
                textField.keyboardType = .numberPad
            }

            alert.addTextField { (textField) in
                textField.placeholder = "To"
                textField.keyboardType = .numberPad
            }

            let action = UIAlertAction(title: "Submit", style: .default) { [unowned alert] _ in
                guard let fromTextField = alert.textFields?[0], let toTextField = alert.textFields?[1] else {
                    return
                }

                guard let fromNumber = Int(fromTextField.text ?? ""), let toNumber = Int(toTextField.text ?? "") else {
                    return
                }
                
                // Store numbers in two variables
                self.rangeFrom = fromNumber
                self.rangeTo = toNumber
                self.mainScreen.textField.text = "\(fromNumber)..\(toNumber)"
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            alert.addAction(action)
            alert.addAction(cancelAction)

            present(alert, animated: true)
        }

        private func handleMultipleNumbersButtonTapped() {
            clearTheTextField()
            
            let alert = UIAlertController(title: "Type as much numbers as you want and put a comma after each of them but the last", message: "Like this: 1,2,3", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Understand", style: .cancel)

            alert.addAction(cancelAction)

            present(alert, animated: true)
        }
    
    private func handleDisplayFactButtonTapped() {
        print("Hello")
        let yourViewController = YourViewController()
           yourViewController.modalPresentationStyle = .fullScreen // Optional: if you want the new view to take up the whole screen
           self.present(yourViewController, animated: true, completion: nil)
    }
    
    func clearTheTextField() {
        mainScreen.textField.text = ""
    }
}

extension ViewController: MainScreenDelegate {
    func didSelectButton(_ button: UIButton) {
        handleButtonTapped(button)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn:"0123456789.,")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

