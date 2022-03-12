//
//  CollectionViewControllerExtentions.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 12.03.22.
//

import UIKit

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: screenWidth/2, height: screenWidth/2)
    }
}
