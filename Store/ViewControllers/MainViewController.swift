//
//  MainViewController.swift
//  Store
//
//  Created by Serge Bowski on 2/1/24.
//

import UIKit
import Alamofire

final class MainViewController: HorizontalPeekingPagesCollectionViewController {
    
    private var pizzas: [Pizza] = []
    private let networkManager = NetworkManager.shared
    
    override func loadView() {
        super.loadView()
//        fetchPizzas()
        manualFetchPizzas()
    }

}

// MARK: - UICollectionViewDataSource
extension MainViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return pizzas.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "pizzaCell",
            for: indexPath
        )
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
        CGSize(
            width: Int(view.window?.windowScene?.screen.bounds.width ?? 0) - 47,
            height: 500
        )
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchPizzas() {
        guard let url = URL(string: "https://ice43.github.io/data_json.json") else {
            return
        }
        
        networkManager.fetch([Pizza].self, from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let pizzas):
                self.pizzas = pizzas
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Manual parsing with Alamofire in VC
extension MainViewController {
    private func manualFetchPizzas() {
//        guard let urlError = URL(string: "https://dogstudio.co/404/") else {
//            return
//        }
        
        AF.request("https://ice43.github.io/data_json.json")
            .validate()
            .responseJSON { [unowned self] dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let pizzasJSON = value as? [[String: Any]] else { return }
                    

                    for pizza in pizzasJSON {
                        let pizza = Pizza(pizzaDetails: pizza)
                        pizzas.append(pizza)
                        
                        print(pizza)
                    }
            
                    collectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}

