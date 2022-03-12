//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var identifier = "CellId"
    var controller: DetailController?
    var titleLabelText = UILabel()
    var subtitleLabelText = UILabel()
    var firstItemLabel = UILabel()
    var firstItemValue = UILabel()
    var secondItemLabel = UILabel()
    var secondItemValue = UILabel()
    var thirdItemLabel = UILabel()
    var thirdItemValue = UILabel()
    var listTitle = UILabel()
    var listItemsLabel = UILabel()
    var listItemsTableView = UITableView()
    var exitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        config()
        controller?.fetchList()
        self.listItemsTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: identifier)
        
    }
}

