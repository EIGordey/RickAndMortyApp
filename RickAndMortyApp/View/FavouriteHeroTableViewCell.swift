//
//  FavouriteHeroCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 12.03.22.
//


import UIKit

class FavouriteHeroTableViewCell: UITableViewCell {
    
    var data: HeroToRealm? {
        didSet {
            titleLabel.text = data?.name
            subtitleLabel.text = "Id:\(data?.id ?? 0)"
            firstItemValue.text = "Status: \(data?.status ?? "")"
            secondItemValue.text = "Gender: \(data?.gender ?? "")"
            thirdItemValue.text = "Species: \(data?.species ?? "")"
        }
    }
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        label.textColor = UIColor.systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = UIColor.systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let firstItemValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.systemBlue
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondItemValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.systemBlue
        label.textAlignment = .left
        return label
    }()
    
    let thirdItemValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.systemBlue
        label.textAlignment = .left
        return label
    }()
    
    let mainView = UIView()
    var descriptionView = UIView()
    
    let containerView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView() {
        descriptionView.isHidden = true
        containerView.axis = .vertical
        contentView.addSubview(containerView)
        containerView.addArrangedSubview(mainView)
        containerView.addArrangedSubview(descriptionView)
        mainView.addSubview(titleLabel)
        descriptionView.addSubview(subtitleLabel)
        descriptionView.addSubview(firstItemValue)
        descriptionView.addSubview(secondItemValue)
        descriptionView.addSubview(thirdItemValue)
        containerView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor)
        mainView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        descriptionView.anchor(top: mainView.bottomAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        titleLabel.anchor(top: mainView.topAnchor, bottom: mainView.bottomAnchor, leading: mainView.leadingAnchor, paddingLeading: 20, trailing: mainView.trailingAnchor)
        subtitleLabel.anchor(top: descriptionView.topAnchor, leading: descriptionView.leadingAnchor, paddingLeading: 20)
        firstItemValue.anchor(top: subtitleLabel.bottomAnchor, leading: descriptionView.leadingAnchor, paddingLeading: 20)
        secondItemValue.anchor(top: firstItemValue.bottomAnchor, leading: descriptionView.leadingAnchor, paddingLeading: 20)
        thirdItemValue.anchor(top: secondItemValue.bottomAnchor, bottom: descriptionView.bottomAnchor, leading: descriptionView.leadingAnchor, paddingLeading: 20)

    }
    
    var isDetailViewHidden: Bool {
        return descriptionView.isHidden
    }

    func showDetailView() {
        descriptionView.isHidden = false
    }

    func hideDetailView() {
        descriptionView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDetailViewHidden, selected {
            showDetailView()
        } else {
            hideDetailView()
        }
    }

}

