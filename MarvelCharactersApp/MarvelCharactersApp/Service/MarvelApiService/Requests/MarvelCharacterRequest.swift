//
//  MarvelCharacterRequest.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import Foundation
import CommonCrypto

struct MarvelCharacterRequest: MarvelRequest {
    
    var endpoint: String {
        MarvelService.shared.baseURL + "v1/public/characters"
    }
    
    var method: RequestMethod {
        .get
    }
    
    var parameters: [String : String]? {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let apiKey = MarvelService.shared.publicKey
        let privateKey = MarvelService.shared.privateKey
        let hash = "\(timestamp)\(privateKey)\(apiKey)".md5
        
        return ["ts" : timestamp,
                "apikey" : apiKey,
                "hash" : hash]
    }
}
