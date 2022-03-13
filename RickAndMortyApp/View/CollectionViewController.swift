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

        controller?.getNextPage(for: indexPath.row)
        controller?.getLikeButtonStatus(for: indexPath.row, sender: cell.likeButton)
        cell.hero = controller?.getHeroes(for: indexPath.row)
        cell.actionClosure = {
            self.controller?.likeButtonAction(for: indexPath.row, sender: cell.likeButton)
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

