//
//  ViewController.swift
//  FoodMenuApp
//
//

import UIKit

class ViewController: UITabBarController {
    
    var controller = FirebaseController();
    var user : UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.controller.getUser{(user) -> Void in
            if(user.rid==0){
                self.createView(isLogin:false)
            }else{
                self.user = user;
                self.createView(isLogin:true)
            }
            
        }
        
    }
    
    func createView(isLogin:Bool){
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
        
        tabBar.tintColor = .blue
        if(isLogin){
            setViewControllers([lView,hView,fView], animated: true)
            
        }else{
            let loginview = UINavigationController(rootViewController: LoginVC())
            loginview.tabBarItem.image = UIImage(systemName: "person.fill")
            loginview.title = "Login"
            
            
            setViewControllers([hView,loginview], animated: true)
        }
        
    }
}
