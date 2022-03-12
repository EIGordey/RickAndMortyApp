//
//  DBManager.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 10.03.22.
//

import UIKit
import RealmSwift
class DBManager {
    
    private var   database:Realm
    static let   sharedInstance = DBManager()
    private init() {
       database = try! Realm()
    }
    func getDataFromDB() ->   Results<HeroToRealm> {
      let results: Results<HeroToRealm> =   database.objects(HeroToRealm.self)
      return results
     }
     func addData(object: HeroToRealm)   {
          try! database.write {
              database.create(HeroToRealm.self, value: object, update: .all)
             print("Added new object")
          }
     }
      func deleteAllFromDatabase()  {
           try!   database.write {
               database.deleteAll()
           }
      }
      func deleteFromDb(object: HeroToRealm)   {
          try!   database.write {
             database.delete(object)
             
              print("deleted object")
          }
      }
    
    func deleteFromDb(heroID: Int)   {
        try!   database.write {
            let hero = database.object(ofType: HeroToRealm.self, forPrimaryKey: heroID)
            guard hero != nil else {
                return
                }
            database.delete(hero!)
            }
        }
}
