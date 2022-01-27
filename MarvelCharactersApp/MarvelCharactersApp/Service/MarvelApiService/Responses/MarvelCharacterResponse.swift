//
//  MarvelCharacterResponse.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import Foundation

struct MarvelCharacterResponse: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let data: CharacterDataWrapper?
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try values.decodeIfPresent(Int.self, forKey: .code)
        self.status = try values.decodeIfPresent(String.self, forKey: .status)
        self.copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        self.data = try values.decodeIfPresent(CharacterDataWrapper.self, forKey: .data)
    }
}

struct CharacterDataWrapper: Decodable{
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        self.limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        self.total = try values.decodeIfPresent(Int.self, forKey: .total)
        self.count = try values.decodeIfPresent(Int.self, forKey: .count)
        self.results = try values.decodeIfPresent([Character].self, forKey: .results)
    }
}
