//
//  FavouriteHeroesTableViewController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 11.03.22.
//

import UIKit
import RealmSwift
class FavouriteHeroesTableViewController: UITableViewController {
    
    var controller: FavouriteHeroesController?
    var notificationToken: NotificationToken?
    var identifier = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        notification()
        self.tableView.register(FavouriteHeroTableViewCell.self, forCellReuseIdentifier: identifier)
        
    }
    func config() {
        self.navigationItem.title = "Favourite"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getNumberOfRows() ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavouriteHeroTableViewCell
        
        cell?.data = controller?.getHeroes(for: indexPath.row)
        return cell ?? UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavouriteHeroTableViewCell {
            cell.hideDetailView()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.performBatchUpdates(nil)
        }
    }
    
    
    func notification() {
        self.notificationToken = controller?.model?.arrayOfHeroes.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self.tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.endUpdates()
            case .error(let err):
                
                fatalError("\(err)")
            }
        }
    }
}
