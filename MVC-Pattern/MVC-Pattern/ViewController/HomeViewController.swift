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
    
    var category = ""
    
    let jokeHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
        view.layer.cornerRadius = 35
        return view
    }()
    
    var joke: String = "The joke goes here"
    var answer: String = ""
    
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
    
    lazy var jokeAnswer: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = secondaryText
        label.font = UIFont(name: "Inter-Regular", size: 18)
        label.text = answer
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
        jokeAnswer.text = answer
    }
    
    @objc func getJoke() {
        getApi()
//        UIView.animate(withDuration: 0.5) { [self] in
////            self.jokeHolder.transform = jokeHolder.transform.rotated(by: CGFloat.pi)
////            self.jokeHolder.transform = jokeHolder.transform.rotated(by: CGFloat.pi)
//            
//        }
        
        UIView.transition(with: jokeHolder, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        
    }
}

extension HomeViewController: UIGestureRecognizerDelegate {
    func setupUI() {
        self.view.backgroundColor = primary
        
        let backButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "back-arrow"), for: .normal)
            button.backgroundColor = .white
            button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            
            return button
        }()
        
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
            gesture.direction = .right
            return gesture
        }()

        
        view.addSubview(bottomView)
        view.addSubview(jokeHolder)
        jokeHolder.addSubview(jokeLabel)
        jokeHolder.addSubview(jokeAnswer)
        jokeHolder.addGestureRecognizer(gestureRecognizer)
        view.addSubview(getButton)
        view.addSubview(backButton)
        
        jokeHolderLeadingConstraint = jokeHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        jokeHolderTrailingConstraint = jokeHolder.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        jokeHolderLeadingConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.widthAnchor.constraint(equalToConstant: 35),
            
            bottomView.topAnchor.constraint(equalTo: view.centerYAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            jokeHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            jokeHolder.heightAnchor.constraint(equalTo: jokeHolder.widthAnchor),
            jokeHolder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            jokeLabel.leadingAnchor.constraint(equalTo: jokeHolder.leadingAnchor, constant: 40),
            jokeLabel.trailingAnchor.constraint(equalTo: jokeHolder.trailingAnchor, constant: -40),
            jokeLabel.bottomAnchor.constraint(equalTo: jokeHolder.centerYAnchor, constant: -6),
            
            jokeAnswer.topAnchor.constraint(equalTo: jokeHolder.centerYAnchor, constant: 6),
            jokeAnswer.leadingAnchor.constraint(equalTo: jokeLabel.leadingAnchor),
            jokeAnswer.trailingAnchor.constraint(equalTo: jokeLabel.trailingAnchor),
            
            getButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            getButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            getButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            getButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
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
        guard let url = URL(string: "https://v2.jokeapi.dev/joke/\(category)") else { return }
        
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
                    if let newJoke = json["joke"] as? String {
                        self.joke = newJoke
                        self.answer = ""
                    } else {
                        print("Key 'desiredKey' not found in JSON")
                    }
                    
                    if let type = json["type"] as? String {
                        if type == "twopart" {
                            if let setup = json["setup"] as? String {
                                self.joke = setup
                                if let answer = json["delivery"] as? String {
                                    self.answer = answer
                                } else { print("Answer at this key not found")}
                            } else { print("Question at this key not found") }
                        }
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


