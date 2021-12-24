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
import UIKit

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    // MARK: - Public properties
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
    
    // MARK: - Inintializer
    init(url: URL) {
        self.url = url
    }
}

class WebService {
    // MARK: - Public functions
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
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
