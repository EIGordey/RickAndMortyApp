//
//  Protocols.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import Foundation

protocol Displayable {
  var titleLabelText: String { get }
  var subtitleLabelText: String { get }
  var firstItem: (label: String, value: String) { get }
  var secondItem: (label: String, value: String) { get }
  var thirdItem: (label: String, value: String) { get }
  var listTitle: String { get }
  var listItems: [String] { get }
}
