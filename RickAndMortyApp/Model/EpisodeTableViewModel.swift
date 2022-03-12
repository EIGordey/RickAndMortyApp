//
//  EpisodeTableViewModel.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import UIKit

class EpisodeTableViewModel {
    
    var controller: EpisodeController?
    var aryDownloadedData:[Episode]?
    var nextPageUrl = "https://rickandmortyapi.com/api/episode/"
    var selectedItem: Displayable?
}
