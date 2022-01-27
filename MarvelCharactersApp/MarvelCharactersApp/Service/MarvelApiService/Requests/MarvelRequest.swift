//
//  MarvelRequest.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import Foundation

protocol MarvelRequest {
    var endpoint: String {get}
    var method: RequestMethod {get}
    var parameters: [String: String]? {get}
}

extension MarvelRequest {
    func asURLRequest() -> URLRequest? {
        
        var components = URLComponents(string: endpoint)!
        
        components.queryItems = (parameters ?? [:]).map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}

enum RequestMethod: String {
    case get = "GET"
}
