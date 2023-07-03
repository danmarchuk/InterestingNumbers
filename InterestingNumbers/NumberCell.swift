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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.init(name: "OpenSans-Bold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.init(name: "OpenSans-SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    func configure(withTitle title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description

        addSubview(titleLabel)
        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
