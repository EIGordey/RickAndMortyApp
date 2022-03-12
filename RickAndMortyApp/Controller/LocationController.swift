//
//  LocationController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import Foundation

class LocationController {
    
    var view: LocationTableViewController?
    var model: LocationTableViewModel?
    
    func getSelecteditem(for number: Int) {
        model?.selectedItem = model?.aryDownloadedData?[number]
    }
    
    func getNumberOfRows() -> Int? {
        return model?.aryDownloadedData?.count
    }
    
    func getLocations(for number: Int) -> Location? {
        return model?.aryDownloadedData?[number]
    }
    
    func getIntitalRickAndMortyData(){
        model?.aryDownloadedData = []
        getRickAndMortyData()
    }
    
    func getRickAndMortyData() {
        
        guard let urlObj = URL(string: model?.nextPageUrl ?? "") else
        { return }
        
        URLSession.shared.dataTask(with: urlObj) {[weak self](data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let downloadedRickAndMorty = try JSONDecoder().decode(PagedLocations.self, from: data)
                self?.model?.aryDownloadedData?.append(contentsOf: downloadedRickAndMorty.results)
                self?.model?.nextPageUrl = downloadedRickAndMorty.info.next
                
                DispatchQueue.main.async {
                    self?.view?.tableView.reloadData()
                }
                
            } catch {
                print(error)
                
            }
            
        }.resume()
        
    }
    
    init(view: LocationTableViewController, model: LocationTableViewModel) {
        self.view = view
        self.model = model
        
        model.controller = self
        view.controller = self
    }
}
