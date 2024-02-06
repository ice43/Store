//
//  NetworkManager.swift
//  Store
//
//  Created by Serge Bowski on 2/1/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    func fetchPizzas(
        from url: URL,
        completion: @escaping (Result<[Pizza], AFError>) -> Void
    ) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let pizzas = Pizza.getPizzas(from: value)
                    completion(.success(pizzas))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(
        from url: String,
        completion: @escaping (Result<Data, AFError>) -> Void
    ) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
