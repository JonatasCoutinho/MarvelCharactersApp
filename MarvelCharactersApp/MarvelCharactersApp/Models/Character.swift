//
//  Character.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import Foundation
import UIKit


struct Character: Decodable {
    var id: Int?
    let name: String?
    let description: String?
    var image: UIImage?
    let thumbnail: CharacterImage?
    var isFavorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
    
    init(id: Int?, name: String?, description: String?, image: UIImage?, isFavorite: Bool?) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.isFavorite = isFavorite
        thumbnail = nil
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.description = try values.decodeIfPresent(String.self, forKey: .description)
        self.thumbnail = try values.decodeIfPresent(CharacterImage.self, forKey: .thumbnail)
        self.image = nil
    }
}

extension Character: Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.description == rhs.description &&
               lhs.image == rhs.image &&
               lhs.isFavorite == rhs.isFavorite
    }
}


struct CharacterImage: Decodable {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try values.decodeIfPresent(String.self, forKey: .path)
        self.ext = try values.decodeIfPresent(String.self, forKey: .ext)
    }
}

extension CharacterImage {
    
    var url: URL? {
        if let path = path, let ext = ext {
            return URL(string: "\(path).\(ext)")
        } else {
            return nil
        }
    }
}
