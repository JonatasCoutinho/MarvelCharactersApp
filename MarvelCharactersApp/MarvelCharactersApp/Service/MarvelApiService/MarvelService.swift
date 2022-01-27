//
//  MarvelService.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit
import CoreData

final class MarvelService {
    
    let baseURL: String = "https://gateway.marvel.com:443/"
    let privateKey: String = "76cb8d0bd88b49abe3e4d049e6064518062f998c"
    let publicKey: String = "1951bc8fc24c16592930f688c6df1581"
    
    static var shared: MarvelService = {
        let instance = MarvelService()
        return instance
    }()
    
    private init() { }
    
    func fetchContent<T:Decodable>(request: MarvelRequest, completion: @escaping (_ result: Result<T, ServiceError>) -> Void) {
        
        guard let request = request.asURLRequest() else {
            completion(.failure(.defaultError))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completion(.failure(.defaultError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.defaultError))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(.defaultError))
            }
        }
        task.resume()
    }
    
    func fetchContentWithURL(url: URL, completion: @escaping (_ result: Result<Data, ServiceError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completion(.failure(.defaultError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.defaultError))
                return
            }
            
            completion(.success(data))
            
        }.resume()
    }
}
