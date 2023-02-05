//
//  ProfileVC.swift
//  FoodMenuApp
//
//

import UIKit

class ProfileVC: UIViewController , UITextFieldDelegate {
    
    
    var controller = FirebaseController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PROFILE"
        setupViews()
        setupConstraints()
        
        self.controller.getUser{ [self](user) -> Void in
            firstnameInput.text = user.name
            phoneInput.text = user.phone
            emailInput.text = user.email
        }
        foodImage.image = UIImage(named: "profile")
    }
    
    @objc func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    // MARK: Properties -
    let firstnameInput: UITextField = {
        let input =  CTextField(frame: .zero)
        input.placeholder = "Name"
        input.title = "Name"
        input.text = ""
        input.disabledColor = .black
        input.isEnabled = false
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    let emailInput: UITextField = {
        let input =  CTextField(frame: .zero)
        input.placeholder = "E-mail"
        input.title = "E-mail"
        input.text = ""
        input.disabledColor = .black
        input.isEnabled = false
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    let phoneInput: UITextField = {
        let input =  CTextField(frame: .zero)
        input.placeholder = "Phone number"
        input.title = "Phone number"
        input.text = ""
        input.disabledColor = .black
        input.isEnabled = false
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    let foodImage : UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let inputStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10.0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    let logoutBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Log out", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont( ofSize: 16)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 54/2
        btn.addTarget(self, action: #selector(ougOutClick), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func ougOutClick() {
        
        self.controller.logOut()
  
        let home = HomeVC();
        home.user = nil;
        let hView = UINavigationController(rootViewController: home)
        hView.tabBarItem.image = UIImage(systemName: "house")
        hView.title = "Home"
        
        let loginview = UINavigationController(rootViewController: LoginVC())
        loginview.tabBarItem.image = UIImage(systemName: "person")
        loginview.title = "Login"
        
        self.tabBarController?.tabBar.tintColor = .blue
        self.tabBarController?.viewControllers = [hView,loginview];
        self.tabBarController?.selectedIndex = 0;
    }
    
    func setupViews(){
        [foodImage,inputStack,logoutBtn].forEach {
            view.addSubview($0)
        }
        [foodImage,firstnameInput,emailInput,phoneInput].forEach {
            inputStack.addArrangedSubview($0)
        }
    }
    
    
    
    func setupConstraints(){
        
        
        NSLayoutConstraint.activate([
            
            inputStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            inputStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            foodImage.heightAnchor.constraint(equalToConstant: 150),
            firstnameInput.heightAnchor.constraint(equalToConstant: 60),
            emailInput.heightAnchor.constraint(equalToConstant: 60),
            phoneInput.heightAnchor.constraint(equalToConstant: 60),
            
            logoutBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoutBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoutBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logoutBtn.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
}
