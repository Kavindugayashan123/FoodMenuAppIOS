//
//  LoginVC.swift
//  FoodMenuApp
//
//

import UIKit

class LoginVC: UIViewController {
    
    var controller = FirebaseController();
    
    let firstLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Food Menu !"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    let greetingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wellcome back you've been missed"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    let greetingHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .vertical
        holder.spacing = 15
        holder.alignment = .center
        return holder
        
    }()
    
    let emailInput: UITextField = {
        let input =  CTextField(frame: .zero)
        input.placeholder = "Email"
        input.title = "Email"
        input.text = ""
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    let passwordField: UITextField = {
        let input =  CTextField(frame: .zero)
        input.placeholder = "Password"
        input.title = "Password"
        input.text = ""
        input.isSecureTextEntry.toggle()
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    let signInButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        return button
    }()
    
    let signUpButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        return button
    }()
    
    let textFieldHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .vertical
        holder.spacing = 15
        holder.alignment = .center
        return holder
        
    }()
    
    let registerLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Register Now! Click Below"
        return label
    }()

    
    let bottomHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .vertical
        holder.spacing = 45
        holder.alignment = .center
        return holder
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        greetingHolder.insertArrangedSubview(firstLabel, at: 0)
        greetingHolder.insertArrangedSubview(greetingLabel, at: 1)
        
        textFieldHolder.insertArrangedSubview(emailInput, at: 0)
        textFieldHolder.insertArrangedSubview(passwordField, at: 1)
        textFieldHolder.insertArrangedSubview(signInButton, at: 2)
        
        
        bottomHolder.insertArrangedSubview(registerLabel, at: 0)
        bottomHolder.insertArrangedSubview(signUpButton, at: 1)
        
        
        view.addSubview(greetingHolder)
        view.addSubview(textFieldHolder)
        view.addSubview(bottomHolder)
        setupConstraints()
    }
    
    func setupConstraints() {
        greetingHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        greetingHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70).isActive = true
        greetingHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        
        textFieldHolder.topAnchor.constraint(equalTo: greetingHolder.bottomAnchor, constant: 40).isActive = true
        textFieldHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textFieldHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        emailInput.leadingAnchor.constraint(equalTo: textFieldHolder.leadingAnchor, constant: 20).isActive = true
        emailInput.trailingAnchor.constraint(equalTo: textFieldHolder.trailingAnchor, constant: -20).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 60).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: textFieldHolder.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: textFieldHolder.trailingAnchor, constant: -20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        
        signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 90).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: textFieldHolder.leadingAnchor, constant: 20).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: textFieldHolder.trailingAnchor, constant: -20).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 140).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: textFieldHolder.leadingAnchor, constant: 20).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: textFieldHolder.trailingAnchor, constant: -20).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        bottomHolder.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 40).isActive = true
        bottomHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        bottomHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
    }
    
    
    @objc func loginClick() {
        self.controller.login(email: emailInput.text!, password: passwordField.text!) {(success) in
            if(success){
                self.controller.getUser{(user) -> Void in
                   
                    let home = HomeVC();
                    home.user = user;
                    let hView = UINavigationController(rootViewController: home)
                    hView.tabBarItem.image = UIImage(systemName: "house")
                    hView.title = "Home"
                    
                    let lView = UINavigationController(rootViewController: ProfileVC())
                    lView.tabBarItem.image = UIImage(systemName: "person")
                    lView.title = "Profile"
                    
                    let fView = UINavigationController(rootViewController: FavouriteVC())
                    fView.tabBarItem.image = UIImage(systemName: "star")
                    fView.title = "Favourite"
                    
                    self.tabBarController?.tabBar.tintColor = .blue
                    self.tabBarController?.viewControllers = [lView,hView,fView];
                    self.tabBarController?.selectedIndex = 0;
                    self.showAlert(title: "Login Success")
                }
            }else{
                self.showAlert(title: "Invalid Email or Password")
            }
        }
        
        
    }
    
    @objc func registerClick() {
        navigationController?.pushViewController(RegisterVC(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func showAlert(title:String){
        let alertView = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}
