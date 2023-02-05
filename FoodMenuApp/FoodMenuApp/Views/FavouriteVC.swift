//
//  FavouriteVC.swift
//  FoodMenuApp
//
//

import UIKit

class FavouriteVC: UIViewController {

    var foodList : [FoodModel] = []
    let controller  = FirebaseController();
    var categoryList: [String] = ["Beverages","Dairy","Fruits","Grains","ProteinFoods","Vegetables"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        customBackButton()
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.register(FavTableCell.self, forCellReuseIdentifier: FavTableCell.reuseableId)
        
    }
    
    func customBackButton(){
        // custom back button
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward",withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward",withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: .none, action: .none)
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        self.foodList = [];
        
        categoryList.forEach {
            controller.getFoodFavList(type: $0) { (foodListGet) in
                DispatchQueue.main.async {
                    self.foodList.append(contentsOf: foodListGet);
                    self.orderTableView.reloadData();
                }
            }
        }
    }
    
    let heading: UILabel = {
        let lb = UILabel()
        lb.text = "My Favourite"
        lb.textColor = color.black
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let orderTableView: UITableView = {
        let list = UITableView(frame: .zero)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.showsVerticalScrollIndicator = false
        return list
    }()
}

extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavTableCell.reuseableId, for: indexPath) as! FavTableCell
        let item = foodList[indexPath.row]
        cell.setData(for: item)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FoodVC()
        
        let food = foodList[indexPath.row]
        vc.food = food;
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setupViews() {
        view.addSubview(heading)
        view.addSubview(orderTableView)
    }
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            heading.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            heading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            orderTableView.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 10),
            orderTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            orderTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            orderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}
