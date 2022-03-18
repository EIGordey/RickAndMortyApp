//
//  EpisodeTableViewController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import UIKit

class EpisodeTableViewController: UITableViewController {
    
    var controller: EpisodeController?
    override func viewDidLoad() {
        super.viewDidLoad()
        controller?.getIntitalRickAndMortyData()
        config()
    }
    
    // MARK: - Table view data source
    
    func config() {
        self.navigationItem.title = "Episodes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getNumberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        controller?.getNextPage(for: indexPath.row)
        let cell = UITableViewCell()
        cell.textLabel?.text = controller?.getEpisode(for: indexPath.row)?.name
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller?.getSelecteditem(for: indexPath.row)
        let view = DetailViewController()
        let model = DetailModel()
        model.data = controller?.model?.selectedItem
        _ = DetailController(view: view, model: model)
        view.modalPresentationStyle = .automatic
        present(view, animated: true, completion: nil)
    }
}
