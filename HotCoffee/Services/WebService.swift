//
//  WebService.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//
// MARK: - Private properties
// MARK: - View functions
// MARK: - Private functions
// MARK: - @objc private functions

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

struct Resource<T: Codable> {
    // MARK: - Public properties
    let url: URL
}

class WebService {
    // MARK: - Public functions
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }

            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
