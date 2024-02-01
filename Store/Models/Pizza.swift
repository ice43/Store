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
}

struct Details: Decodable {
    let image: URL
    let size: String
    let description: String
    let price: String
}
