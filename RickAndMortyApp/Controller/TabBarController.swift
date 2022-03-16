//
//  TabBarController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//

import UIKit

class TabBarController {
    
    var view: TabBarView?
    var model: TabBarModel?
    var collectionController: CollectionController?
    var episodeController: EpisodeController?
    var locationController: LocationController?
    var favouriteController: FavouriteHeroesController?
    
    func getBar() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = CollectionViewController(collectionViewLayout: layout)
        let collectionModel = CollectionViewModel()
        let collectionNavigation = UINavigationController(rootViewController: collectionView)
        let collection = CollectionController(view: collectionView, model: collectionModel)
        let collectionTitle = UITabBarItem(title: "Heroes", image: UIImage(named: "characters"), selectedImage: UIImage(named: "characters_active"))
        collection.view?.tabBarItem = collectionTitle
        collectionNavigation.tabBarItem = collectionTitle
        
        let episodeView = EpisodeTableViewController()
        let episodeNavigation = UINavigationController(rootViewController: episodeView)
        let episodeModel = EpisodeTableViewModel()
        let episodeTableView = EpisodeController(view: episodeView, model: episodeModel)
        let episodeTitle = UITabBarItem(title: "Episodes", image: UIImage(named: "episodes"), selectedImage: UIImage(named: "episodes_active"))
        episodeTableView.view?.tabBarItem = episodeTitle
        episodeNavigation.tabBarItem = episodeTitle
        
        let locationView = LocationTableViewController()
        let locationNavigation = UINavigationController(rootViewController: locationView)
        let locationModel = LocationTableViewModel()
        let locationTableView = LocationController(view: locationView, model: locationModel)
        let locationTitle = UITabBarItem(title: "Locations", image: UIImage(named: "locations"), selectedImage: UIImage(named: "locations_active"))
        locationTableView.view?.tabBarItem = locationTitle
        locationNavigation.tabBarItem = locationTitle
        
        let favHeroes = FavouriteHeroesTableViewController()
        let favHeroesNavigation = UINavigationController(rootViewController: favHeroes)
        let favModel = FavouriteHeroesModel()
        let favTableView = FavouriteHeroesController(view: favHeroes, model: favModel)
        let favTitle = UITabBarItem(title: "Favourite", image: UIImage(named: "fav"), selectedImage: nil)
        favTableView.view?.tabBarItem.selectedImage = UIImage(named: "fav_active")
        favTableView.view?.tabBarItem = favTitle
        favHeroesNavigation.tabBarItem  = favTitle
        
        let controllers = [collectionNavigation, episodeNavigation, locationNavigation, favHeroesNavigation ]
        self.locationController = locationTableView
        self.episodeController = episodeTableView
        self.collectionController = collection
        self.favouriteController = favTableView
        self.view?.setViewControllers(controllers, animated: true)
        
    }
    
    init(view: TabBarView, model: TabBarModel) {
        self.view = view
        self.model = model
        
        view.controller = self
        model.controller = self
    }
}
