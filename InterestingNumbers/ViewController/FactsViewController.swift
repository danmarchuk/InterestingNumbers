//
//  FactsScreen.swift
//  InterestingNumbers
//
//  Created by Данік on 03/07/2023.
//

import UIKit
import SnapKit

// Create the ViewController with CollectionView
final class FactsViewController: UIViewController, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView!
    var userInput = ""
    var numbersManager = NumbersManager()

    private var numbers: [String] = []
    private var factsAboutNumbers: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        numbersManager.delegate = self
        numbersManager.fetchFacts(numbers: userInput)
        view.backgroundColor = K.purple
        // Setup collectionView
        configureCollectionView()
        addElements()
        imageButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    // Create a UIButton and set its image
    let imageButton = UIButton().apply {
        $0.setImage(UIImage(named: "close"), for: .normal)
        $0.tintColor = .white
    }

    @objc func rightButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func addElements() {
        view.addSubview(collectionView)
        view.addSubview(imageButton)
        
        imageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(334)
        }
        
        // Setup collectionView constraints
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NumberCell.self, forCellWithReuseIdentifier: NumberCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension FactsViewController: NumbersManagerDelegate {
    func didUpdateNumberFacts(_ manager: NumbersManager, facts: [String : String]) {
        
        let sortedFacts = facts.sorted { $0.key.localizedStandardCompare($1.key) == .orderedAscending }

        for (key, value) in sortedFacts {
            numbers.append(key)
            factsAboutNumbers.append(value)
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
    }
}


// MARK: - UICollectionViewDataSource

extension FactsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.identifier, for: indexPath) as? NumberCell else {
            return UICollectionViewCell()
        }
        cell.configure(withTitle: numbers[indexPath.row], description: factsAboutNumbers[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FactsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 2)
    }
}

