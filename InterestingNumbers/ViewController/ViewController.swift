//
//  ViewController.swift
//  InterestingNumbers
//
//  Created by Данік on 30/06/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    let mainScreen = MainScreen()
    let collectionView = FactsViewController()
    var displayOneFact = true
    
    override func loadView() {
        mainScreen.delegate = self
        view = mainScreen
        mainScreen.textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up button actions
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
            displayOneFact = true
            clearTheTextField()
        }

        private func handleRandomNumberButtonTapped() {
            displayOneFact = true
            mainScreen.textField.text = "\(Int.random(in: 0...1000))"
        }

        private func handleNumberInRangeButtonTapped() {
            displayOneFact = false
            let alert = UIAlertController(title: "Provide two numbers for the range", message: "", preferredStyle: .alert)

            alert.addTextField { (textField) in
                textField.placeholder = "From"
                textField.keyboardType = .numberPad
                textField.accessibilityIdentifier = "fromTextField"
            }

            alert.addTextField { (textField) in
                textField.placeholder = "To"
                textField.keyboardType = .numberPad
                textField.accessibilityIdentifier = "toTextField"
            }

            let action = UIAlertAction(title: "Submit", style: .default) { [unowned alert] _ in
                guard let fromTextField = alert.textFields?[0], let toTextField = alert.textFields?[1] else {
                    return
                }

                guard let fromNumber = Int(fromTextField.text ?? ""), let toNumber = Int(toTextField.text ?? "") else {
                    return
                }
                
                self.mainScreen.textField.text = "\(fromNumber)..\(toNumber)"
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            alert.addAction(action)
            alert.addAction(cancelAction)

            present(alert, animated: true)
        }

        private func handleMultipleNumbersButtonTapped() {
            displayOneFact = false
            clearTheTextField()
            
            let alert = UIAlertController(title: "Type as much numbers as you want and put a comma after each of them but the last", message: "Like this: 1,2,3", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Understand", style: .cancel)

            alert.addAction(cancelAction)

            present(alert, animated: true)
        }
    
    private func handleDisplayFactButtonTapped() {
        guard let numbers = mainScreen.textField.text else {return}
        let factsViewController = FactsViewController()
        if displayOneFact {
            factsViewController.numbersManager.parseOneFact = true
            factsViewController.numbersManager.userInputNumber = numbers
        } else {
            factsViewController.numbersManager.parseOneFact = false
        }
        factsViewController.userInput = numbers
        factsViewController.modalPresentationStyle = .fullScreen
        self.present(factsViewController, animated: true, completion: nil)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
