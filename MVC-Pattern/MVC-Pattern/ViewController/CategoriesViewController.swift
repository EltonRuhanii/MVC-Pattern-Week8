//
//  CategoriesViewController.swift
//  MVC-Pattern
//
//  Created by Kin+Carta on 23.1.24.
//

import UIKit

class CategoriesViewController: UIViewController {
    let background = UIColor(named: "BackgroundC")
    let primary = UIColor(named: "PrimaryC")
    let secondary = UIColor(named: "SecondaryC")
    let textColor = UIColor(named: "TextC")
    let secondaryText = UIColor(named: "SecondaryTextC")
    
    let categories = ["Dark", "Programming", "Pun", "Spooky"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = background
        
        let buttonView = createButtonView(with: categories)
        view.addSubview(buttonView)
    }
    
    func createButtonView(with categories: [String]) -> UIView {
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        var buttons: [UIButton] = []
        
        for (index, category) in categories.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(category, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        view.addSubview(buttonView)
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            buttonView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: buttonView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            stackView.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
        ])
        
        return buttonView
    }


        
        @objc func buttonTapped(_ sender: UIButton) {
            let vc = HomeViewController()
            vc.category = sender.currentTitle ?? "Any"
            self.navigationController?.pushViewController(vc, animated: true)
        }
}
