//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Евгений Гордей on 7.03.22.
//

import UIKit

class InitialViewController: UIViewController {
    var controller: TabBarController?
    let label = UILabel()
    let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        settingEllements()
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       get {
          return .portrait
       }
    }

    func settingEllements() {
        label.text = "You Are Welcome"
        label.textColor = .systemBlue
        button.setTitle("Click here to continue", for: .normal)
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 25
//        button.layer.shadowOffset = CGSize(width: 10, height: 10)
//        button.layer.shadowRadius = 5
//        button.layer.shadowOpacity = 0.3
        view.addSubview(label)
        view.addSubview(button)
        view.backgroundColor = .white
        label.anchor(centerX: view.layoutMarginsGuide.centerXAnchor, centerY: view.layoutMarginsGuide.centerYAnchor)
        button.anchor(top: label.topAnchor, paddingTop: 30,centerX: view.layoutMarginsGuide.centerXAnchor, width: 200, height: 50)
    }
    
    @objc func buttonTapped(sender : UIButton) {
        UIView.animate(withDuration: 0.6,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.6) {
                sender.transform = CGAffineTransform.identity
            }
        })
        let view = TabBarView()
        let model = TabBarModel()
        let controller = TabBarController(view: view, model: model)
        self.controller = controller
        view.modalPresentationStyle = .overFullScreen
        view.modalTransitionStyle = .flipHorizontal
        present(view, animated: true, completion: nil)
              
        
    }
}

