//
//  PizzaCell.swift
//  Store
//
//  Created by Serge Bowski on 2/1/24.
//

import UIKit

final class PizzaCell: UICollectionViewCell {
    
    @IBOutlet private weak var imagePizza: UIImageView!
    @IBOutlet private weak var namePizza: UILabel!
    @IBOutlet private weak var sizePizza: UILabel!
    @IBOutlet private weak var descriptionPizza: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with pizza: Pizza) {
        namePizza.text = pizza.name
        sizePizza.text = pizza.data.size
        descriptionPizza.text = pizza.data.description
        addButton.setTitle("+ \(pizza.data.price)", for: .normal)
        
        networkManager.fetchImage(from: pizza.data.image) { [unowned self] imageData in
            imagePizza.image = UIImage(data: imageData)
        }
    }
}
