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
        config()
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let heroName = searchBar.text else { return }
        controller?.searchHero(for: heroName)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        controller?.getFirstpage()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.count ?? 0 > 1 {
            controller?.searchHero(for: searchController.searchBar.text ?? "")
        }
    }
    
    func config() {
        self.navigationItem.title = "Heroes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController?.delegate = self
        self.searchController?.searchBar.delegate = self
        self.definesPresentationContext = true
        self.searchController?.hidesNavigationBarDuringPresentation = false
        self.searchController?.searchResultsUpdater = self
        searchController?.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchController?.searchBar
        self.searchController?.searchBar.placeholder = "Enter Hero's name"
        self.searchController?.searchBar.enablesReturnKeyAutomatically = true
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

