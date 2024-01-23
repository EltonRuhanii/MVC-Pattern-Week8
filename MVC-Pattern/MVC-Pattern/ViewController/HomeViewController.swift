//
//  ViewController.swift
//  Week8-MVC Pattern's
//
//  Created by Elton Ruhani @Kin+Carta on 22.1.24.
//

import UIKit

class HomeViewController: UIViewController {
    let background = UIColor(named: "BackgroundC")
    let primary = UIColor(named: "PrimaryC")
    let secondary = UIColor(named: "SecondaryC")
    let textColor = UIColor(named: "TextC")
    let secondaryText = UIColor(named: "SecondaryTextC")
    
    let jokeHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
        view.layer.cornerRadius = 35
        return view
    }()
    
    var joke: String = "The joke goes here"
    
    private var jokeHolderLeadingConstraint: NSLayoutConstraint!
    private var jokeHolderTrailingConstraint: NSLayoutConstraint!
    
    lazy var jokeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = textColor
        label.font = UIFont(name: "Inter-Regular", size: 18)
        label.text = joke
        label.numberOfLines = 4
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupUI()
        
    }
    
    func newJoke() {
        jokeLabel.text = joke
    }
    
    @objc func getJoke() {
        getApi()
//        UIView.animate(withDuration: 0.5) { [self] in
////            self.jokeHolder.transform = jokeHolder.transform.rotated(by: CGFloat.pi)
////            self.jokeHolder.transform = jokeHolder.transform.rotated(by: CGFloat.pi)
//            
//        }
        
        UIView.transition(with: jokeHolder, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
    }
}

extension HomeViewController: UIGestureRecognizerDelegate {
    func setupUI() {
        self.view.backgroundColor = primary
        
        let bottomView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = background
            return view
        }()
    
        let getButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
            button.setTitle("Get joke", for: .normal)
            button.layer.cornerRadius = 15
            button.addTarget(self, action: #selector(getJoke), for: .touchUpInside)
            return button
        }()
        
        let gestureRecognizer: UISwipeGestureRecognizer = {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
            gesture.delegate = self
            gesture.direction = .left
            return gesture
        }()


        view.addSubview(bottomView)
        view.addSubview(jokeHolder)
        jokeHolder.addSubview(jokeLabel)
        jokeHolder.addGestureRecognizer(gestureRecognizer)
        view.addSubview(getButton)
        
        jokeHolderLeadingConstraint = jokeHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        jokeHolderTrailingConstraint = jokeHolder.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        jokeHolderLeadingConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: view.centerYAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            jokeHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            jokeHolder.heightAnchor.constraint(equalTo: jokeHolder.widthAnchor),
            jokeHolder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            jokeLabel.topAnchor.constraint(equalTo: jokeHolder.topAnchor, constant: 40),
            jokeLabel.leadingAnchor.constraint(equalTo: jokeHolder.leadingAnchor, constant: 40),
            jokeLabel.trailingAnchor.constraint(equalTo: jokeHolder.trailingAnchor, constant: -40),
            jokeLabel.bottomAnchor.constraint(equalTo: jokeHolder.bottomAnchor, constant: -40),
            
            getButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            getButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            getButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            getButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc func didSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right: 
            getJoke()
            UIView.transition(with: jokeHolder, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        case .left:
            getJoke()
            UIView.transition(with: jokeHolder, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        default: break
        }
    }
    
    func getApi() {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                return
            }
            
            do {
                // Parse the JSON data
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Access the specific value you want
                    if let newJoke = json["value"] as? String {
                        self.joke = newJoke.replacingOccurrences(of: "Chuck Norris", with: "Halil Budakova")
                    } else {
                        print("Key 'desiredKey' not found in JSON")
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }.resume()
        
        DispatchQueue.main.async {
            self.newJoke()
            }
        }
    
    }


