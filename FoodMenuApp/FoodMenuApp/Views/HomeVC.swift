//
//  HomeVC.swift
//  FoodMenuApp
//
//

import UIKit

class HomeVC: UIViewController {

    let controller = FirebaseController();

    var categoryList: [String] = ["Beverages","Dairy","Fruits","Grains","ProteinFoods","Vegetables"]

    var Beverages:[FoodModel]=[]
    var Dairy:[FoodModel]=[]
    var Fruits:[FoodModel]=[]
    var Grains:[FoodModel]=[]
    var ProteinFoods:[FoodModel]=[]
    var Vegetables:[FoodModel]=[]
    
    let reusableId = "cellId"
    let foodCustomLayout = FoodCustomLayout.shared
    var user : UserModel? = nil
    
    var myCollectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FOOD HOME"
        setupViews()
        setupConstraints()
        customBackButton()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeFoodViewCell.self, forCellWithReuseIdentifier: HomeFoodViewCell.reusableId)

        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: HeaderView.reusableId, withReuseIdentifier: HeaderView.reusableId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reusableId)


        loadData()
    }
    
 
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData();
    }

    
    func customBackButton(){
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward",withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward",withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: .none, action: .none)
        navigationController?.navigationBar.tintColor = .black
    }
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    
    func setupViews(){
        view.addSubview(container)
        container.addSubview(collectionView)
        setupCompositionalLayout()
    }
    func setupCompositionalLayout(){
        let layout = UICollectionViewCompositionalLayout { sectionNumber, env in

            return self.foodCustomLayout.foodLayout()

        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    func setupConstraints(){
        container.pin(to: view)
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: container.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
        ])
    }
    
    
    func loadData(){
    
        controller.getFoodList(type: "Beverages") { (foodListGet) in
            DispatchQueue.main.async {
                self.Beverages = foodListGet;
                self.collectionView.reloadData();
            }
        }
        controller.getFoodList(type: "Dairy") { (foodListGet) in
            DispatchQueue.main.async {
                self.Dairy = foodListGet;
                self.collectionView.reloadData();
            }
        }
        
        controller.getFoodList(type: "Fruits") { (foodListGet) in
            DispatchQueue.main.async {
                self.Fruits = foodListGet;
                self.collectionView.reloadData();
            }
        }
        controller.getFoodList(type: "Grains") { (foodListGet) in
            DispatchQueue.main.async {
                self.Grains = foodListGet;
                self.collectionView.reloadData();
            }
        }
        controller.getFoodList(type: "ProteinFoods") { (foodListGet) in
            DispatchQueue.main.async {
                self.ProteinFoods = foodListGet;
                self.collectionView.reloadData();
            }
        }
        controller.getFoodList(type: "Vegetables") { (foodListGet) in
            DispatchQueue.main.async {
                self.Vegetables = foodListGet;
                self.collectionView.reloadData();
            }
        }
    }

    
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return Beverages.count
        }else if(section == 1){
            return Dairy.count
        }else if(section == 2){
            return Fruits.count
        }else if(section == 3){
            return Grains.count
        }else if(section == 4){
            return ProteinFoods.count
        }else if(section == 5){
            return Vegetables.count
        }
        
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFoodViewCell.reusableId, for: indexPath) as! HomeFoodViewCell
            cell.data = Beverages[indexPath.row]
            return cell
        }else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFoodViewCell.reusableId, for: indexPath) as! HomeFoodViewCell
            cell.data = Dairy[indexPath.row]
            return cell
        }else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFoodViewCell.reusableId, for: indexPath) as! HomeFoodViewCell
            cell.data = Fruits[indexPath.row]
            return cell
        }else if indexPath.section == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFoodViewCell.reusableId, for: indexPath) as! HomeFoodViewCell
            cell.data = Grains[indexPath.row]
            return cell
        }else if indexPath.section == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFoodViewCell.reusableId, for: indexPath) as! HomeFoodViewCell
            cell.data = ProteinFoods[indexPath.row]
            return cell
        }else if indexPath.section == 5 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFoodViewCell.reusableId, for: indexPath) as! HomeFoodViewCell
            cell.data = Vegetables[indexPath.row]
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId, for: indexPath)
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reusableId, for: indexPath) as! HeaderView
        view.headingLabel.text = categoryList[indexPath.section]
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FoodVC()
        vc.category  = categoryList[indexPath.section]
        vc.user = user
        if indexPath.section == 0{
            let food = Beverages[indexPath.row]
            vc.food = food;
        }else  if indexPath.section == 1{
            let food = Dairy[indexPath.row]
            vc.food = food;
        }else  if indexPath.section == 2{
            let food = Fruits[indexPath.row]
            vc.food = food;
        }else  if indexPath.section == 3{
            let food = Grains[indexPath.row]
            vc.food = food;
        }else  if indexPath.section == 4{
            let food = ProteinFoods[indexPath.row]
            vc.food = food;
        }else  if indexPath.section == 5{
            let food = Vegetables[indexPath.row]
            vc.food = food;
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}




extension UIView {
    
    func pin(to superview: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func addBottomShadows(){
        layer.shadowColor = color.grey.cgColor
        layer.shadowRadius = 3
        layer.masksToBounds  = false
        layer.shadowOffset =  CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.6
        backgroundColor = .white
        layer.shadowPath = CGPath(rect: CGRect(x: 0,y: bounds.maxY - layer.shadowRadius,width: bounds.width,height: layer.shadowRadius), transform: .none)
    }
    func removeBottomShadows(){
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset =  CGSize(width: 0, height: 3)
        layer.shadowRadius = 0
        layer.masksToBounds  = false
        layer.shadowOpacity = 0
        layer.shadowPath = nil
    }
}
