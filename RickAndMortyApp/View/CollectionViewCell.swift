//
//  CollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var actionClosure: (()->())?
    var hero : Hero? {
        didSet {
            showCaseImageView.something(urlString: hero?.image ?? "")
            nameLabel.text = hero?.name
           
        }
    }
    
    let showCaseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.systemBlue
        
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.addTarget(self, action: #selector(clickOnLikeButton), for: .valueChanged)
        return button
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)

            addViews()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addViews() {
        addSubview(showCaseImageView)
        addSubview(nameLabel)
        addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(clickOnLikeButton), for: .touchUpInside)
        showCaseImageView.anchor(top: contentView.layoutMarginsGuide.topAnchor , leading: contentView.layoutMarginsGuide.leadingAnchor, trailing: contentView.layoutMarginsGuide.trailingAnchor)
        nameLabel.anchor(top: showCaseImageView.bottomAnchor,paddingTop: 5, bottom: contentView.layoutMarginsGuide.bottomAnchor, paddingBottom: 5,  leading: showCaseImageView.leadingAnchor, paddingLeading: 5,trailing: layoutMarginsGuide.trailingAnchor)
        likeButton.anchor(top: nameLabel.topAnchor, trailing: layoutMarginsGuide.trailingAnchor, paddingTrailing: 5)
    }
    
    @objc func clickOnLikeButton(sender : UIButton) {
        actionClosure?()
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = likeButton.hitTest(likeButton.convert(point, from: self), with: event)
        if view == nil {
            view = super.hitTest(point, with: event)
        }

        return view
    }
    
}

