//
//  FactsScreen.swift
//  InterestingNumbers
//
//  Created by Данік on 03/07/2023.
//

import UIKit

// Create the ViewController with CollectionView
class FactsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    var userInput = ""
    var numbersManager = NumbersManager()

    private var numbers: [String] = []
    private var factsAboutNumbers: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        numbersManager.delegate = self
        numbersManager.fetchFacts(numbers: userInput)
        view.backgroundColor = .purple

        // Setup collectionView
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
        view.addSubview(collectionView)

        // Setup collectionView constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.identifier, for: indexPath) as! NumberCell
        cell.configure(withTitle: numbers[indexPath.row], description: factsAboutNumbers[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 2)
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

