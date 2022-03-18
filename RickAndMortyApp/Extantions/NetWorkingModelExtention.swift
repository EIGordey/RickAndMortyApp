//
//  NetWorkingModelExtention.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import Foundation

extension Hero: Displayable {
    
    var titleLabelText: String {
        name
    }
    
    var subtitleLabelText: String {
        "Status:\(status ?? "")"
    }
    
    var firstItem: (label: String, value: String) {
        ("Species", species ?? "")
    }
    
    var secondItem: (label: String, value: String) {
        ("Gender", gender ?? "")
    }
    
    var thirdItem: (label: String, value: String) {
        if let something = location?.name {
       return ("Origin", something)
        }
        return ("Origin", "something")
    }
    
    var listTitle: String {
        "Episodes"
    }
    
    var listItems: [String] {
        episode ?? [""]
    }
    
}

extension Location: Displayable {
    
    var titleLabelText: String {
        name
    }
    
    var subtitleLabelText: String {
        "Location Id: \(id ?? 0)"
    }
    
    var firstItem: (label: String, value: String) {
        ("Type", type ?? "")
    }
    
    var secondItem: (label: String, value: String) {
        ("Dimension", dimension ?? "Unknown")
    }
    
    var thirdItem: (label: String, value: String) {
        ("Location URL", url)
    }
    
    var listTitle: String {
        "Residents"
    }
    
    var listItems: [String] {
        residents ?? [""]
    }
    
}

extension Episode: Displayable {
    
    var titleLabelText: String {
        name
    }
    
    var subtitleLabelText: String {
        "Episode Id: \(id)"
    }
    
    var firstItem: (label: String, value: String) {
        ("Air Date",air_date ?? "")
    }
    
    var secondItem: (label: String, value: String) {
        ("Episode", episode)
    }
    
    var thirdItem: (label: String, value: String) {
        ("Episode URL", url)
    }
    
    var listTitle: String {
        "Characters"
    }
    
    var listItems: [String] {
        characters
    }
    
    
}
