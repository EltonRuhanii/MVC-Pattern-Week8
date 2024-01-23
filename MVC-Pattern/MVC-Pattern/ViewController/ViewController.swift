//
//  ViewController.swift
//  Week8-MVCPattern
//
//  Created by Kin+Carta on 22.1.24.
//

import UIKit

class ViewController: UIViewController {
    let background = UIColor(named: "BackgroundC")
    let primary = UIColor(named: "PrimaryC")
    let secondary = UIColor(named: "SecondaryC")
    let textColor = UIColor(named: "TextC")
    let secondaryText = UIColor(named: "SecondaryTextC")
    
    let titledTextField = TextFieldView()
    let passwordTextField = TextFieldView()
    
    var enteredUsername: String = ""
    var enteredPassword: String = ""
    
    var existingUsers: [User] = [
        User(username: "EltonR", password: "1234"),
        User(username: "Wizzardi", password: "12"),
        User(username: "WIZZ", password: "EltonR"),
        User(username: "1", password: "1")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func buttonClicked(username: String, password: String) {
        
    }
    
    @objc private func goToHomePage() {
        let homeController = ViewController()
        present(homeController, animated: true, completion: nil)
    }
}

extension ViewController {
    func setupUI() {
        view.backgroundColor = background
        
        let loginHolder: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = primary
            view.layer.cornerRadius = 25
            return view
        }()
        
        let logo: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = textColor
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.text = "LOGO"
            label.textAlignment = .center
            
            return label
        }()
        
        
        titledTextField.configure(title: "Username")
        titledTextField.backgroundColor = background
        titledTextField.layer.cornerRadius = 10
        titledTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        passwordTextField.configure(title: "Password", secure: true)
        passwordTextField.backgroundColor = background
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let loginButton = Button()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(textColor, for: .normal)
        loginButton.addTarget(self, action: #selector(postApi), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loginHolder)
        view.addSubview(logo)
        view.addSubview(titledTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        
        NSLayoutConstraint.activate([
            loginHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginHolder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            loginHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            logo.topAnchor.constraint(equalTo: loginHolder.topAnchor, constant: 32),
            logo.leadingAnchor.constraint(equalTo: loginHolder.leadingAnchor, constant: 32),
            logo.trailingAnchor.constraint(equalTo: loginHolder.trailingAnchor, constant: -32),
            logo.heightAnchor.constraint(equalToConstant: 40),
            
            titledTextField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32),
            titledTextField.leadingAnchor.constraint(equalTo: loginHolder.leadingAnchor, constant: 32),
            titledTextField.trailingAnchor.constraint(equalTo: loginHolder.trailingAnchor, constant: -32),
            
            passwordTextField.topAnchor.constraint(equalTo: titledTextField.bottomAnchor, constant: 32),
            passwordTextField.leadingAnchor.constraint(equalTo: loginHolder.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: loginHolder.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            titledTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginHolder.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 32),
        ])
    }
    
    @objc func postApi() {
        let params = [
            "username": titledTextField.textField.text,
            "password": passwordTextField.textField.text
        ]

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                if let data = data {
                    do {
                        let jsonRes = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        self.handleResponse(jsonRes)
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                }
            } else {
                print("Unexpected response: \(response.debugDescription)")
            }
        }.resume()
    }

    func handleResponse(_ jsonRes: [String: Any]?) {
        guard
            let username = jsonRes?["username"] as? String,
            let password = jsonRes?["password"] as? String
        else {
            print("No username or password key found in the JSON response")
            return
        }

        self.enteredUsername = username
        self.enteredPassword = password
        self.checkUsernameAndPassword()
    }

    @objc func checkUsernameAndPassword() {
        if existingUsers.contains(where: { $0.username == enteredUsername && $0.password == enteredPassword }) {
            print("Welcome back \(enteredUsername)")
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            }
        } else {
            print("Invalid username or password. Try signing up first.")
        }
    }
}
