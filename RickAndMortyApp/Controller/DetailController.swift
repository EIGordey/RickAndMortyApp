//
//  DetailController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import UIKit
import Alamofire

class DetailController {
    
    var view: DetailViewController?
    var model: DetailModel?
    
    private func fetch<T: Codable & Displayable>(_ list: [String], of: T.Type) {
        var items: [T] = []
        let fetchGroup = DispatchGroup()
        list.forEach { (url) in
            fetchGroup.enter()
            AF.request(url).validate().responseDecodable(of: T.self) { (response) in
                if let value = response.value {
                    items.append(value)
                }
                fetchGroup.leave()
            }
        }
        fetchGroup.notify(queue: .main) {
            self.model?.listData = items
            self.view?.listItemsTableView.reloadData()
        }
    }
    
    func fetchList() {
        guard let data = model?.data else { return }
        switch data {
        case is Hero:
            fetch(data.listItems, of: Episode.self)
        case is Episode:
            fetch(data.listItems, of: Hero.self)
        case is Location:
            fetch(data.listItems, of: Hero.self)
        default:
            print("Unknown type: ", String(describing: type(of: data)))
        }
    }
    func getNumberOfRows() -> Int? {
        return model?.listData.count
    }
    
    func getEpisode(for number: Int) -> Displayable? {
        return model?.listData[number]
    }
    init(view: DetailViewController, model: DetailModel) {
        self.view = view
        self.model = model
        
        model.controller = self
        view.controller = self
    }
    
}
