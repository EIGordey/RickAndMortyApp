//
//  LocationTableViewController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import UIKit

class LocationTableViewController: UITableViewController {
    
    var controller: LocationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        controller?.getIntitalRickAndMortyData()
        config()
        
    }
    
    func config() {
        self.navigationItem.title = "Locations"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return controller?.getNumberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let count = controller?.getNumberOfRows(), count>1{
            let lastElement = count - 1
            if indexPath.row == lastElement {
                controller?.getRickAndMortyData()
            }
        }
        let cell = UITableViewCell()
        cell.textLabel?.text = controller?.getLocations(for: indexPath.row)?.name
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller?.getSelecteditem(for: indexPath.row)
        let view = DetailViewController()
        let model = DetailModel()
        model.data = controller?.model?.selectedItem
        let controller = DetailController(view: view, model: model)
        view.modalPresentationStyle = .automatic
        present(view, animated: true, completion: nil)
    }
}
