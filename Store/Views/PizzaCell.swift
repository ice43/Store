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
    @IBOutlet private weak var pricePizza: UILabel!
    
    func configure(with pizza: Pizza) {
        namePizza.text = pizza.name
        sizePizza.text = pizza.data.size
        descriptionPizza.text = pizza.data.description
        pricePizza.text = pizza.data.price
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: pizza.data.image) else { return }
            DispatchQueue.main.async { [unowned self] in
                imagePizza.image = UIImage(data: imageData)
            }
        }
    }
}
