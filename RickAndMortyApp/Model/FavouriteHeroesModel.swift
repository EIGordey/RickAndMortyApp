//
//  FavouriteHeroesModel.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 11.03.22.
//

import Foundation
import RealmSwift
class FavouriteHeroesModel {
    
    var controller: FavouriteHeroesController?
    var arrayOfHeroes = DBManager.sharedInstance.getDataFromDB()
}
