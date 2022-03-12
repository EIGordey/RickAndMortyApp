//
//  LocationTableViewModel.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import UIKit

class LocationTableViewModel {
    
    var controller : LocationController?
    var aryDownloadedData:[Location]?
    var nextPageUrl = "https://rickandmortyapi.com/api/location/"
    var selectedItem: Displayable?
}
