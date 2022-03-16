//
//  CollectionController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//

import UIKit
import RealmSwift
import Alamofire

class CollectionController {
    
    var view: CollectionViewController?
    var model: CollectionViewModel?
    
    
    func getNumberOfRows() -> Int? {
        return model?.aryDownloadedData?.count
    }
    
    func getHeroes(for number: Int) -> Hero? {
        return model?.aryDownloadedData?[number]
    }
    
    func getSelecteditem(for number: Int) {
        model?.selectedItem = model?.aryDownloadedData?[number]
    }
    
    func getIntitalRickAndMortyData(){
        model?.aryDownloadedData = []
        getRickAndMortyData()
    }
    
    func getFirstpage() {
        AF.request("https://rickandmortyapi.com/api/character")
            .validate()
            .responseDecodable(of: PagedCharacters.self) { response in
                guard let heroes = response.value else { return }
                self.model?.aryDownloadedData = heroes.results
                self.view?.collectionView.reloadData()
            }
    }
    
    func getNextPage(for number: Int) {
        if let count = getNumberOfRows(), count>1{
            let lastElement = count - 1
            if number == lastElement {
                getRickAndMortyData()
            }
        }
    }
    
    func getRickAndMortyData() {
        guard let urlObj = URL(string: model?.nextPageUrl ?? "") else
        { return }
        URLSession.shared.dataTask(with: urlObj) {[weak self](data, response, error) in
            guard let data = data else { return }
            do {
                let downloadedRickAndMorty = try JSONDecoder().decode(PagedCharacters.self, from: data)
                self?.model?.aryDownloadedData?.append(contentsOf: downloadedRickAndMorty.results)
                self?.model?.nextPageUrl = downloadedRickAndMorty.info?.next ?? ""
                
                DispatchQueue.main.async {
                    self?.view?.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func createHero(for number: Int) -> HeroToRealm {
        let hero =  HeroToRealm()
        hero.id = model?.aryDownloadedData?[number].id ?? 0
        hero.name = model?.aryDownloadedData?[number].name ?? ""
        hero.status = model?.aryDownloadedData?[number].status ?? ""
        hero.species = model?.aryDownloadedData?[number].species ?? ""
        hero.gender = model?.aryDownloadedData?[number].gender ?? ""
        hero.image = model?.aryDownloadedData?[number].image ?? ""
        return hero
    }
    
    func addDataToRealm(hero: HeroToRealm) {
        DBManager.sharedInstance.addData(object: hero)
        
    }
    func getDataFromDB(hero: HeroToRealm) -> Results<HeroToRealm> {
        DBManager.sharedInstance.getDataFromDB().where {
            $0.id == hero.id
        }
    }
    
    func getLikeButtonStatus(for number: Int, sender: UIButton) {
        let hero = createHero(for: number)
        let count = getDataFromDB(hero: hero).count
        
        if count == 1 {
            sender.isSelected = true
        } else {
            sender.isSelected = false
        }
    }
    
    func likeButtonAction(for number: Int, sender: UIButton) {
        let hero = createHero(for: number)
        if sender.isSelected == true {
            sender.isSelected = false
            deleteObject(for: hero.id)
        } else {
            sender.isSelected = true
            addDataToRealm(hero: hero)
        }
    }
    
    func deleteObject(for heroId: Int) {
        DBManager.sharedInstance.deleteFromDb(heroID: heroId)
    }
    
    func searchHero(for name: String) {
        let url = "https://rickandmortyapi.com/api/character"
        let parameters: [String: String] = ["name": name]
        AF.request(url, parameters: parameters).validate()
            .responseDecodable(of: PagedCharacters.self) { response in
                guard let heroes = response.value else { return }
                self.model?.aryDownloadedData = heroes.results
                self.view?.collectionView.reloadData()
            }
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let heroName = searchBar.text else { return }
        searchHero(for: heroName)
    }
    
    
    init(view: CollectionViewController, model: CollectionViewModel) {
        self.view = view
        self.model = model
        
        model.controller = self
        view.controller = self
    }
    
    
}
