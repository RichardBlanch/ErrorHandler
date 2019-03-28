//
//  Networking.swift
//  SampleProject
//
//  Created by Richard Blanchard on 3/28/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import ErrorHandler

class Networking {
    static let shared = Networking()
    
    private let urlSession = URLSession.shared
    
    func fetchBadURL(_ completion: @escaping (Result<String, NetworkingError>) -> Void) throws {
        guard let url = URL(string: "I AM A BAD STRING") else { throw NetworkingError.badURL }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(NetworkingError.genericError(error)))
            } else if let data = data {
                completion(.success(String(data: data, encoding: .utf8)!))
            } else {
                completion(.failure(NetworkingError.noData))
            }
        }.resume()
    }
    
    func fetchGoodURL(_ completion: @escaping (Result<String, NetworkingError>) -> Void) throws {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/8863.json?print=pretty") else { throw NetworkingError.badURL }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(NetworkingError.genericError(error)))
            } else if let _ = data {
                completion(.success("Successfully Fetched Data!"))
            } else {
                completion(.failure(NetworkingError.noData))
            }
        }.resume()
    }
}

