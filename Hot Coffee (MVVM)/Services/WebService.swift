//
//  WebService.swift
//  Hot Coffee (MVVM)
//
//  Created by Youssef Eldeeb on 23/05/2023.
//

import Foundation


enum NetworkError: Error{
    case decodingError
    case domainError
    case urlError
}

struct Resource<T: Codable>{
    let url: URL
}

class WebService{
    static var shared = WebService()
    
    func load<T>(resouce: Resource<T>, completion: @escaping (Result<T,NetworkError>) -> (Void)){
        URLSession.shared.dataTask(with: resouce.url) { data, response, error in
            guard let data = data, error == nil else{
                completion(.failure(.domainError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result{
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            }else{
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
