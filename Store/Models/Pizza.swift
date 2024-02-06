//
//  Pizza.swift
//  Store
//
//  Created by Serge Bowski on 2/1/24.
//

import Foundation

struct Pizza: Decodable {
    let name: String
    let data: Details
    
    init(name: String, data: Details) {
        self.name = name
        self.data = data
    }
    
    init(pizzaDetails: [String: Any]) {
        name = pizzaDetails["name"] as? String ?? ""
        data = Details(pizzaDetails: pizzaDetails["data"] as? [String : Any] ?? [:])
    }
    
//    static func getPizzas(from value: Any) -> [Pizza] {
//        guard let pizzasDetails = value as? [[String: Any]] else { return [] }
//        return pizzasDetails.map { Pizza(pizzaDetails: $0) }
//    }
}

struct Details: Decodable {
    var image: URL
    var size: String
    var description: String
    var price: String
    
    init(image: URL, size: String, description: String, price: String) {
        self.image = image
        self.size = size
        self.description = description
        self.price = price
    }
    
    init(pizzaDetails: [String: Any]) {
        image = pizzaDetails["image"] as? URL ?? URL(fileURLWithPath: "")
        size = pizzaDetails["size"] as? String ?? ""
        description = pizzaDetails["description"] as? String ?? ""
        price = pizzaDetails["price"] as? String ?? ""
    }
}
