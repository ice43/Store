//
//  MainViewController.swift
//  Store
//
//  Created by Serge Bowski on 2/1/24.
//

import UIKit

final class MainViewController: HorizontalPeekingPagesCollectionViewController {
    
    private var pizzas: [Pizza] = []
    private let networkManager = NetworkManager.shared
    
    override func loadView() {
        super.loadView()
        fetchDevices()
    }

}

// MARK: - UICollectionViewDataSource
extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pizzas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pizzaCell", for: indexPath)
        guard let cell = cell as? PizzaCell else { return UICollectionViewCell() }
        let pizza = pizzas[indexPath.item]
        
        cell.configure(with: pizza)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: Int(view.window?.windowScene?.screen.bounds.width ?? 0) - 47, height: 500)
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchDevices() {
        guard let url = URL(string: "https://ice43.github.io/data_json.json") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self else { return }
            guard let data else {
                print(error ?? "no error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                pizzas = try decoder.decode([Pizza].self, from: data)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}


