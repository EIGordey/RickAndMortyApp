//
//  CollectionViewController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//

import UIKit


private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var controller: CollectionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller?.getIntitalRickAndMortyData()
        config()
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func config() {
        self.navigationItem.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller?.getNumberOfRows() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        if let count = controller?.getNumberOfRows(), count>1{
            let lastElement = count - 1
            if indexPath.row == lastElement {
                controller?.getRickAndMortyData()
            }
        }
        
        guard let hero = controller?.createHero(for: indexPath.row) else {
            return UICollectionViewCell()
        }
        
        guard let count = controller?.getDataFromDB(hero: hero).count else {
            return UICollectionViewCell()
        }
        
        if count == 1  {
            cell.likeButton.isSelected = true
        } else {
            cell.likeButton.isSelected = false
        }
        
        cell.hero = controller?.getHeroes(for: indexPath.row)
        cell.actionClosure = {
            if cell.likeButton.isSelected == true {
                cell.likeButton.isSelected = false
                self.controller?.deleteObject(for: hero.id)
            } else {
                cell.likeButton.isSelected = true
                self.controller?.addDataToRealm(hero: hero)
            }
        }
        return cell
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = self.collectionView.indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        self.collectionView.scrollToItem(at: index, at: .left, animated: true )
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

