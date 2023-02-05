//
//  FoodVC.swift
//  FoodMenuApp
//
//

import UIKit

class FoodVC: UIViewController {
    
    var food: FoodModel?
    var user : UserModel?
    var category : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        
        view.addSubview(lblHolder)
        view.addSubview(imageHolder)
        view.isUserInteractionEnabled = true
        imageHolder.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        imageHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        
        lblHolder.topAnchor.constraint(equalTo: imageHolder.bottomAnchor, constant: 10).isActive = true
        lblHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        lblHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        imageHolder.addArrangedSubview(foodImage);
        foodImage.contentMode = .scaleAspectFill
        foodImage.clipsToBounds=true
        
        favHolder.insertArrangedSubview(favButton, at: 0)
        
        favHolder.isHidden = user == nil
        
        lblHolder.insertArrangedSubview(favHolder, at: 0)
        lblHolder.insertArrangedSubview(foodName, at: 1)
        lblHolder.insertArrangedSubview(foodCal, at: 2)
        lblHolder.insertArrangedSubview(foodDesc, at: 3)
        navigationController?.navigationBar.isHidden = false
        

        foodName.text = food?.name;
        foodDesc.text = food?.description;
        foodCal.text = "Calorie Count: \( food?.calorieCount as! Int)"
        foodImage.kf.setImage(with: URL(string: food?.imgURL ?? ""))
        
    }
    let foodName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    let foodDesc : UILabel = {
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: 35, height: 45))
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    let foodCal : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    let lblHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .vertical
        holder.spacing = 15
        holder.alignment = .center
        holder.isUserInteractionEnabled = true
        return holder
        
    }()
    let imageHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .vertical
        holder.spacing = 15
        holder.alignment = .center
        return holder
        
    }()
    
    let favHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .horizontal
        holder.spacing = 5
        return holder
        
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
    
    let favButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(systemName: "star")
        img?.withTintColor(.blue)
        button.setImage(img, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        return button
    }()
    
    // hide tabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -1
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
    }
    
    
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: color.black]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        let leftButton = UIBarButtonItem()
        leftButton.customView = backButton
        navigationItem.setLeftBarButton(leftButton, animated: true)
    }
    @objc func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    
    let controller = FirebaseController();
    @objc func addToFavourite() {
        
        controller.addFavouriteFood(category: category, food_id: food!.id, user: user!)
    }
}
