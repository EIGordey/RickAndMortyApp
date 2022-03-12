//
//  TestViewController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 8.03.22.
//

import UIKit

class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var controller: EpisodeController?
    var table = EpisodeTableViewController()
    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = table
        tableView.delegate = table
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.anchor(top: view.topAnchor, paddingTop: 20, leading: view.leadingAnchor, width: 150, height: 400)
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.model?.aryDownloadedData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let count = controller?.model?.aryDownloadedData?.count, count>1{
            let lastElement = count - 1
            if indexPath.row == lastElement {
                controller?.getRickAndMortyData()
            }
        }
        let cell = UITableViewCell()
        cell.textLabel?.text = controller?.model?.aryDownloadedData?[indexPath.row].name
            return cell
        

    }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


