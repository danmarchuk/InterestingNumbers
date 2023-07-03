//
//  MainScreen.swift
//  InterestingNumbers
//
//  Created by Данік on 30/06/2023.
//

import Foundation
import UIKit
import SnapKit

protocol MainScreenDelegate: AnyObject {
    func didSelectButton(_ button: UIButton)
}

@IBDesignable
class MainScreen: UIView {
    static let textColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1)
    static let buttonColor = UIColor(red: 0.98, green: 0.97, blue: 0.99, alpha: 1.0)
    static let borderColor = UIColor(red: 245/255, green: 239/255, blue: 251/255, alpha: 1).cgColor
    static let purple = UIColor(red: 128/255, green: 51/255, blue: 204/255, alpha: 1.0)
    static let grayIsh = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
    
    weak var delegate: MainScreenDelegate?
    var selectedButton: UIButton?

    let someLabel = UILabel().apply {
        $0.text = "Interesting Numbers"
        $0.font = UIFont(name: "OpenSans-Bold", size: 28)
    }
    
    let someOtherLabel = UILabel().apply {
        $0.text = "This App about facts of Numbers \nand Dates"
        $0.font = UIFont(name: "OpenSans-Light", size: 16)
        $0.textColor = grayIsh
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    let cubesImage = UIImageView().apply {
        $0.image  = UIImage(named: "cubes")
    }
    
    let userNumberButton = createButton(with: "User\nNumber")
    let randomNumberButton = createButton(with: "Random\nNumber")
    let numberInRangeButton = createButton(with: "Number\nin a range")
    let multipleNumbersButton = createButton(with: "Multiple\nNumbers")
    
    let enterHereLabel = UILabel().apply {
        $0.text = "Enter here"
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.textColor = .black
    }
    
    let rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.98, green: 0.97, blue: 0.99, alpha: 1.0)
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.96, green: 0.94, blue: 0.98, alpha: 1.0).cgColor
        return view
    }()
    
    let textField = UITextField().apply {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = MainScreen.textColor
        $0.backgroundColor = .clear
        $0.borderStyle = .none
        $0.layer.cornerRadius = 6
        $0.layer.borderColor = MainScreen.borderColor
        $0.textAlignment = .left
        $0.keyboardType = .numberPad
    }
    
    let displayFactButton = UIButton().apply {
        $0.setTitle("Display Fact", for: .normal)
        $0.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = MainScreen.purple
        $0.layer.cornerRadius = 5
    }
    
    static func createButton(with title: String) -> UIButton {
        return UIButton(type: .system).apply {
            $0.setTitle(title, for: .normal)
            $0.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 13)
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.numberOfLines = 0
            $0.setTitleColor(MainScreen.textColor, for: .normal)
            $0.backgroundColor = MainScreen.buttonColor
            $0.layer.cornerRadius = 6
            $0.layer.borderWidth = 1
            $0.layer.borderColor = MainScreen.borderColor
        }
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        addElements()
        configureButtons()
        configure()
    }
    
    private func configureButtons() {
        userNumberButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        randomNumberButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        numberInRangeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        multipleNumbersButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        displayFactButton.addTarget(self, action: #selector(displayFactButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        // Reset the previously selected button's color
        selectedButton?.backgroundColor = MainScreen.buttonColor
        selectedButton?.setTitleColor(MainScreen.textColor, for: .normal)
        
        // Highlight the tapped button
        sender.backgroundColor = MainScreen.purple
        sender.setTitleColor(.white, for: .normal)
        
        // Update the selected button
        selectedButton = sender
        
        // Notify the delegate of the selected button
        delegate?.didSelectButton(sender)
    }
    
    @objc private func displayFactButtonTapped(_ sender: UIButton) {
        // Notify the delegate of the selected button
        delegate?.didSelectButton(sender)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
    }
    
    private func addElements() {
        addSubview(someLabel)
        addSubview(someOtherLabel)
        addSubview(cubesImage)
        addSubview(rectangleView)
        rectangleView.addSubview(textField)
        addSubview(enterHereLabel)
        addSubview(displayFactButton)
        
        let buttonStackView = UIStackView(arrangedSubviews: [userNumberButton, randomNumberButton, numberInRangeButton, multipleNumbersButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 8
        addSubview(buttonStackView)
        
        userNumberButton.snp.makeConstraints { make in
            make.height.equalTo(74)
            make.width.equalTo(75)
        }
        
        someLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(88)
            make.centerX.equalToSuperview()
        }
        
        someOtherLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        cubesImage.snp.makeConstraints { make in
            make.height.equalTo(144)
            make.width.equalTo(180)
            make.top.equalToSuperview().offset(253)
            make.left.equalTo(97)
        }
        
        rectangleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(606)
            make.width.equalTo(343)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.edges.equalTo(rectangleView).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        }
        
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(486)
            make.left.equalTo(27)
        }
        
        enterHereLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(580)
            make.left.equalToSuperview().offset(29)
        }
        
        displayFactButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(670)
            make.width.equalTo(343)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
        }
    }
}
