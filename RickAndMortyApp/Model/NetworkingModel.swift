//
//  NetworkingModel.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//

import Foundation

struct PagedCharacters: Codable {
    
    let info: Info
    let results: [Hero]

}

struct PagedLocations: Codable {
    
    let info: Info
    let results: [Location]

}

struct PagedEpisode: Codable {
    
    let info: Info
    let results: [Episode]

}

struct Info: Codable {
    
    let count: Int
    let pages: Int
    let next: String
    let prev: String?
}

struct Hero: Codable {
    
    let id: Int
    let name: String
    let status: String?
    let species: String?
    let gender: String?
    let origin: Location?
    let location: Location?
    let image: String?
    let episode: [String]?
}

struct Location: Codable {
    
    let id: Int?
    let name: String
    let type: String?
    let dimension: String?
    let residents: [String]?
    let url: String
    
}

struct Episode: Codable {
    
    let id: Int
    let name: String
    let air_date: String?
    let episode: String
    let characters: [String]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case air_date
        case episode
        case characters
        case url
    }
    
}

