//
//  CollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    var actionClosure: (()->())?
    var hero : Hero? {
        didSet {
            guard let url = URL(string: hero?.image ?? "") else {return}
            showCaseImageView.kf.indicatorType = .activity
            showCaseImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
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
        contentView.addSubview(showCaseImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(clickOnLikeButton), for: .touchUpInside)
        showCaseImageView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, paddingBottom: -20, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor)
        nameLabel.anchor(top: showCaseImageView.bottomAnchor,paddingTop: 5, bottom: contentView.bottomAnchor, paddingBottom: 5,  leading: showCaseImageView.leadingAnchor, paddingLeading: 5,trailing: contentView.trailingAnchor, paddingTrailing: -30)
        likeButton.anchor(top: showCaseImageView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTrailing: -10)
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

