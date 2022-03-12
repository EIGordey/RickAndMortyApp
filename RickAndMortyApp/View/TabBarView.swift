//
//  TabBarViewViewController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//

import UIKit

class TabBarView: UITabBarController {
    
    var controller: TabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller?.getBar()
        
    }
}
