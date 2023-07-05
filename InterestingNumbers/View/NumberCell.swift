//
//  NumberCell.swift
//  InterestingNumbers
//
//  Created by Данік on 03/07/2023.
//

import UIKit

// Create a custom UICollectionViewCell
class NumberCell: UICollectionViewCell {
    static let identifier = "NumberCell"

    private let numberLabel = UILabel().apply {
        $0.textAlignment = .center
        $0.font = UIFont.init(name: "OpenSans-Bold", size: 28)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.accessibilityIdentifier = "numberLabel"
    }

    private let factLabel = UILabel().apply {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.init(name: "OpenSans-SemiBold", size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.accessibilityIdentifier = "factLabel"
    }

    func configure(withTitle title: String, description: String) {
        numberLabel.text = title
        factLabel.text = description

        addSubview(numberLabel)
        addSubview(factLabel)

        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }

        factLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
