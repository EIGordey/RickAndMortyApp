//
//  UiviewExtentions.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//


import UIKit
extension  UIView {
    
    /// Takes four constraints with padding for each of them and values for height and width anchors
    /// - Parameters:
    ///   - top: top constraint, "nil" by default
    ///   - paddingTop: padding for top constraint, "0" by default
    ///   - bottom: bottom constraint, "nil" by default
    ///   - paddingBottom: padding for bottom constraint, "0" by default
    ///   - leading: left constraint, "nil" by default
    ///   - paddingLeading: padding for left constraint, "0" by default
    ///   - trailing: right constraint, "nil" by default
    ///   - paddingTrailing: padding for right constraint, "0" by default
    ///   - centerX: X-center constraint, "nil" by default
    ///   - paddingCenterX: - padding for centerX constraint, "0" by default
    ///   - centerY: Y-center constraint, "nil" by default
    ///   - paddingCenterY: - padding for centerY constraint, "0" by default
    ///   - width: value for width anchor, "0" by default
    ///   - height: value for height anchor, "0" by default
    func anchor(top : NSLayoutYAxisAnchor? = nil,
                paddingTop : CGFloat = 0,
                bottom : NSLayoutYAxisAnchor? = nil,
                paddingBottom : CGFloat = 0,
                leading: NSLayoutXAxisAnchor? = nil,
                paddingLeading: CGFloat = 0,
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingTrailing: CGFloat = 0,
                centerX: NSLayoutXAxisAnchor? = nil,
                paddingCenterX: CGFloat = 0,
                centerY: NSLayoutYAxisAnchor? = nil,
                paddingCenterY: CGFloat = 0,
                width: CGFloat = 0,
                height: CGFloat = 0
    ){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: paddingTrailing).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: paddingCenterX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: paddingCenterY).isActive = true
        }
        
        if  width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if  height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension UIImageView {
    func something(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
