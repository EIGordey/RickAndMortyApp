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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
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
    func config() {
        self.navigationItem.title = "Favourite"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getNumberOfRows() ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = controller?.getHeroes(for: indexPath.row)?.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}
