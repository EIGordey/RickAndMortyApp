//
//  DBModel.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 10.03.22.
//

import UIKit
import RealmSwift
class HeroToRealm: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var species: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var image: String = ""
    
    override static func primaryKey() -> String? {
        
            return "id"
          }
    
    convenience init(id: Int, name: String, status: String, species: String, gender: String, image: String ) {
        
        self.init()
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
    }
}
