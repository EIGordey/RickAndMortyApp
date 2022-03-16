//
//  EpisodeController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import UIKit

class EpisodeController {
    
    var view: EpisodeTableViewController?
    var model: EpisodeTableViewModel?
    
    func getSelecteditem(for number: Int) {
        model?.selectedItem = model?.aryDownloadedData?[number]
    }
    
    func getNumberOfRows() -> Int? {
        return model?.aryDownloadedData?.count
    }
    
    func getEpisode(for number: Int) -> Episode? {
        return model?.aryDownloadedData?[number]
    }
    
    func getIntitalRickAndMortyData(){
        model?.aryDownloadedData = []
        getRickAndMortyData()
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
                let downloadedRickAndMorty = try JSONDecoder().decode(PagedEpisode.self, from: data)
                self?.model?.aryDownloadedData?.append(contentsOf: downloadedRickAndMorty.results)
                self?.model?.nextPageUrl = downloadedRickAndMorty.info.next ?? ""
                
                DispatchQueue.main.async {
                    self?.view?.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    init(view: EpisodeTableViewController, model: EpisodeTableViewModel) {
        self.view = view
        self.model = model
        
        model.controller = self
        view.controller = self
    }
}
