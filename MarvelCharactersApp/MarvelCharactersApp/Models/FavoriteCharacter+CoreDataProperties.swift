//
//  FavoriteCharacter+CoreDataProperties.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 24/01/22.
//
//

import Foundation
import CoreData


extension FavoriteCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCharacter> {
        return NSFetchRequest<FavoriteCharacter>(entityName: "FavoriteCharacter")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var image: Data?

}

extension FavoriteCharacter : Identifiable {

}
