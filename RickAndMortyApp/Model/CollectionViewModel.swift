//
//  CollectionViewModel.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//

import UIKit

class CollectionViewModel {
    
    var controller : CollectionController?
    var aryDownloadedData:[Hero]?
    var nextPageUrl = "https://rickandmortyapi.com/api/character/"
    var selectedItem: Displayable?
}
