//
//  DetailViewControllerExtentions.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 12.03.22.
//

import UIKit

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func config() {
        
        titleLabelText.textColor = .systemBlue
        titleLabelText.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabelText.textAlignment = .left
        titleLabelText.numberOfLines = 1
        
        subtitleLabelText.textColor = .systemBlue
        subtitleLabelText.font = UIFont.systemFont(ofSize: 16)
        subtitleLabelText.textAlignment = .left
        subtitleLabelText.numberOfLines = 1
        
        firstItemLabel.textColor = .systemBlue
        firstItemLabel.font = UIFont.boldSystemFont(ofSize: 20)
        firstItemLabel.textAlignment = .left
        firstItemLabel.numberOfLines = 1
        
        firstItemValue.textColor = .systemBlue
        firstItemValue.font = UIFont.systemFont(ofSize: 16)
        firstItemValue.textAlignment = .left
        firstItemValue.numberOfLines = 1
        
        secondItemLabel.textColor = .systemBlue
        secondItemLabel.font = UIFont.boldSystemFont(ofSize: 20)
        secondItemLabel.textAlignment = .left
        secondItemLabel.numberOfLines = 1
        
        secondItemValue.textColor = .systemBlue
        secondItemValue.font = UIFont.systemFont(ofSize: 16)
        secondItemValue.textAlignment = .left
        secondItemValue.numberOfLines = 1
        
        thirdItemLabel.textColor = .systemBlue
        thirdItemLabel.font = UIFont.boldSystemFont(ofSize: 20)
        thirdItemLabel.textAlignment = .left
        thirdItemLabel.numberOfLines = 1
        
        thirdItemValue.textColor = .systemBlue
        thirdItemValue.font = UIFont.systemFont(ofSize: 16)
        thirdItemValue.textAlignment = .left
        thirdItemValue.numberOfLines = 1
        
        listItemsLabel.textColor = .systemBlue
        listItemsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        listItemsLabel.textAlignment = .left
        listItemsLabel.numberOfLines = 1
        
        exitButton.addTarget(self, action: #selector(self.exit), for: .touchUpInside)
        exitButton.setImage(UIImage(systemName: "clean"), for: .normal)
        
        
        view.addSubview(titleLabelText)
        view.addSubview(subtitleLabelText)
        view.addSubview(firstItemLabel)
        view.addSubview(firstItemValue)
        view.addSubview(secondItemLabel)
        view.addSubview(secondItemValue)
        view.addSubview(thirdItemLabel)
        view.addSubview(thirdItemValue)
        view.addSubview(listItemsLabel)
        view.addSubview(listItemsTableView)
        view.addSubview(exitButton)
        view.backgroundColor = .systemBackground
        titleLabelText.anchor(top: view.layoutMarginsGuide.topAnchor, paddingTop: 20, leading: view.leadingAnchor, paddingLeading: 20)
        
        exitButton.anchor(top: view.layoutMarginsGuide.topAnchor, paddingTop: 20, trailing: view.layoutMarginsGuide.trailingAnchor)
        
        subtitleLabelText.anchor(top: titleLabelText.bottomAnchor,paddingTop: 20, leading: view.leadingAnchor, paddingLeading: 20)
        
        firstItemLabel.anchor(top: subtitleLabelText.bottomAnchor, paddingTop: 20, leading: view.leadingAnchor, paddingLeading: 20)
        
        firstItemValue.anchor(top: firstItemLabel.bottomAnchor, paddingTop: 20, leading: view.leadingAnchor, paddingLeading: 20)
        
        secondItemLabel.anchor(top: firstItemValue.bottomAnchor, paddingTop: 20, leading: view.leadingAnchor, paddingLeading: 20)
        
        secondItemValue.anchor(top: secondItemLabel.bottomAnchor, paddingTop: 20, leading: view.leadingAnchor, paddingLeading: 20)
        
        thirdItemLabel.anchor(top: secondItemValue.bottomAnchor, paddingTop: 20, leading: view.leadingAnchor, paddingLeading: 20)
        
        thirdItemValue.anchor(top: thirdItemLabel.bottomAnchor, paddingTop: 20, leading: view.leadingAnchor, paddingLeading: 20)
        
        listItemsLabel.anchor(top: thirdItemValue.bottomAnchor, paddingTop: 20, leading: view.leadingAnchor, paddingLeading: 20)
        
        listItemsTableView.anchor(top: listItemsLabel.bottomAnchor, paddingTop: 20, bottom: view.bottomAnchor, paddingBottom: 20, leading: view.leadingAnchor, trailing: view.trailingAnchor )
        self.listItemsTableView.delegate = self
        self.listItemsTableView.dataSource = self
        self.listItemsTableView.estimatedRowHeight = 100
        self.listItemsTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    @objc func exit(sender : UIButton) {
        UIView.animate(withDuration: 0.6,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.6) {
                sender.transform = CGAffineTransform.identity
            }
        })
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func commonInit() {
        guard let data = controller?.model?.data else { return }
        
        titleLabelText.text = data.titleLabelText
        subtitleLabelText.text = data.subtitleLabelText
        
        firstItemLabel.text = data.firstItem.label
        firstItemValue.text = data.firstItem.value
        
        secondItemLabel.text = data.secondItem.label
        secondItemValue.text = data.secondItem.value
        
        thirdItemLabel.text = data.thirdItem.label
        thirdItemValue.text = data.thirdItem.value
        
        listItemsLabel.text = data.listTitle
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listItemsTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? DetailTableViewCell
        cell?.data = controller?.getEpisode(for: indexPath.row)
        return cell ?? UITableViewCell()
    }
   
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = self.listItemsTableView.cellForRow(at: indexPath) as? DetailTableViewCell {
            cell.hideDetailView()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.listItemsTableView.performBatchUpdates(nil)
        }
    }
    
}
