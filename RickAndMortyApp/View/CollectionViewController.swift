//
//  CollectionViewController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    var searchController : UISearchController?
    var controller: CollectionController?
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller?.getIntitalRickAndMortyData()
        self.navigationItem.title = "Heroes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        config()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        controller?.getFirstpage()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        controller?.searchUpdating()
    }
    
    func config() {
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController?.delegate = self
        self.searchController?.searchBar.delegate = self
        self.definesPresentationContext = true
        self.searchController?.searchResultsUpdater = self
        self.searchController?.searchBar.becomeFirstResponder()
        self.searchController?.searchBar.placeholder = "Enter Hero's name"
        self.searchController?.searchBar.enablesReturnKeyAutomatically = true
        navigationItem.searchController = searchController
        self.searchController?.obscuresBackgroundDuringPresentation = false
        self.searchController?.hidesNavigationBarDuringPresentation = true
        self.searchController?.searchBar.scopeButtonTitles = ["Name", "Status", "Species", "Gender"]
        self.collectionView.keyboardDismissMode = .onDrag
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.searchController?.searchBar.placeholder = "Enter Hero's \(searchController?.searchBar.scopeButtonTitles?[selectedScope] ?? "")"
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller?.getNumberOfRows() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        controller?.getNextPage(for: indexPath.row)
        controller?.getLikeButtonStatus(for: indexPath.row, sender: cell.likeButton)
        cell.hero = controller?.getHeroes(for: indexPath.row)
        cell.actionClosure = {
            self.controller?.likeButtonAction(for: indexPath.row, sender: cell.likeButton)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        controller?.getSelecteditem(for: indexPath.row)
        let view = DetailViewController()
        let model = DetailModel()
        model.data = controller?.model?.selectedItem
        let controller = DetailController(view: view, model: model)
        view.modalPresentationStyle = .automatic
        view.modalTransitionStyle = .flipHorizontal
        present(view, animated: true, completion: nil)
    }
    
    
}

