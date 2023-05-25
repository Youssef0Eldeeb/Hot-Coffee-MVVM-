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

enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
}
struct Resource<T: Codable>{
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}
extension Resource {
    init(url: URL){
        self.url = url
    }
}

class WebService{
    static var shared = WebService()
    
    func load<T>(resouce: Resource<T>, completion: @escaping (Result<T,NetworkError>) -> (Void)){
        
        var request = URLRequest(url: resouce.url)
        request.httpMethod = resouce.httpMethod.rawValue
        request.httpBody = resouce.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
