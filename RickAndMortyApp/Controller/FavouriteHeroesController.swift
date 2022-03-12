//
//  FavouriteHeroes.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 11.03.22.
//

import Foundation

class FavouriteHeroesController {
    
    var model: FavouriteHeroesModel?
    var view: FavouriteHeroesTableViewController?
    
    
    func getNumberOfRows() -> Int? {
        return model?.arrayOfHeroes.count
    }
    
    func getHeroes(for number: Int) -> HeroToRealm? {
        return model?.arrayOfHeroes[number]
    }

    init(view: FavouriteHeroesTableViewController, model: FavouriteHeroesModel) {
        self.view = view
        self.model = model
        
        model.controller = self
        view.controller = self
    }
    
}
