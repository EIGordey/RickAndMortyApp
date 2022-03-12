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
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = CollectionViewController(collectionViewLayout: layout)
        let collectionModel = CollectionViewModel()
        let collectionNavigation = UINavigationController(rootViewController: collectionView)
        let collection = CollectionController(view: collectionView, model: collectionModel)
        let collectionTitle = UITabBarItem(title: "Characters", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        collection.view?.tabBarItem = collectionTitle
        collectionNavigation.tabBarItem = collectionTitle
        
        let episodeView = EpisodeTableViewController()
        let episodeNavigation = UINavigationController(rootViewController: episodeView)
        let episodeModel = EpisodeTableViewModel()
        let episodeTableView = EpisodeController(view: episodeView, model: episodeModel)
        let episodeTitle = UITabBarItem(title: "Episodes", image: nil, selectedImage: nil)
        episodeTableView.view?.tabBarItem = episodeTitle
        episodeNavigation.tabBarItem = episodeTitle
        
        let locationView = LocationTableViewController()
        let locationNavigation = UINavigationController(rootViewController: locationView)
        let locationModel = LocationTableViewModel()
        let locationTableView = LocationController(view: locationView, model: locationModel)
        let locationTitle = UITabBarItem(title: "Locations", image: nil, selectedImage: nil)
        locationTableView.view?.tabBarItem = locationTitle
        locationNavigation.tabBarItem = locationTitle
        
        let favHeroes = FavouriteHeroesTableViewController()
        let favHeroesNavigation = UINavigationController(rootViewController: favHeroes)
        let favModel = FavouriteHeroesModel()
        let favTableView = FavouriteHeroesController(view: favHeroes, model: favModel)
        let favTitle = UITabBarItem(title: "Favourite", image: nil, selectedImage: nil)
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
