//
//  FirebaseController.swift
//  FoodMenuApp
//
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseController{
    
    func registerUser(email: String, password: String,name:String,phone:String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(res, error) in
            if let user = res?.user {
                let id=Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
                let data    =  ["rid":id,
                                "name":name,
                                "email":email,
                                "phone":phone
                ] as [String : Any]
                
                var db: DatabaseReference!
                db = Database.database().reference()
                db.child("users").child(user.uid).setValue(data)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func login(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func resetPassword(email: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    
    func getUser(completionBlock: @escaping (_ success: UserModel) -> Void){
        var db: DatabaseReference!
        db = Database.database().reference()
        guard let id = Auth.auth().currentUser?.uid else {
            completionBlock(UserModel(rid: 0, name: "",email:"",phone:""))
            return
        }
        db.child("users").child(id).observeSingleEvent(of: .value, with: { (data) in
            let user = data.value as! [String: Any]
            let usr = UserModel(id: id, rid: user["rid"] as! Int,name: user["name"] as! String,email: user["email"] as! String, phone: user["phone"] as! String)
            completionBlock(usr)
        })
        
    }
    
    
    func getFoodList(type: String,completionBlock: @escaping (_ success: [FoodModel]) -> Void) {
        
        var foods:[FoodModel] = []
        var db: DatabaseReference!
        db = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        db.child(type).queryOrderedByKey().observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                
                let placeDict = snap.value as! [String: Any]
                let img = placeDict["img"] as! String
                let name = placeDict["name"] as! String
                let description = placeDict["description"] as! String
                let calories = placeDict["calories"] as! Int
                let fid = placeDict["id"] as! String
                let val = placeDict[uid ?? "id"] ?? ""
                foods.append(FoodModel(id: fid, imgURL: img, name: name,calorieCount:calories,isFavourite: val as! String=="ADDED",description: description))
            }
            completionBlock(foods)
        }
        
    }
    
    func addFavouriteFood(category: String,food_id:String,user:UserModel){
        print(Auth.auth().currentUser!.uid)
        var db: DatabaseReference!
        db = Database.database().reference()
        db.child(category).child(food_id).child(Auth.auth().currentUser!.uid).setValue("ADDED")
    }
    
    
    func getFoodFavList(type: String,completionBlock: @escaping (_ success: [FoodModel]) -> Void) {
        
        var foods:[FoodModel] = []
        var db: DatabaseReference!
        db = Database.database().reference()
        
        let uid = Auth.auth().currentUser?.uid
        
        db.child(type).queryOrderedByKey().observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let placeDict = snap.value as! [String: Any]
                let val = placeDict[uid ?? "id"] ?? ""
                if(val as! String=="ADDED"){
                    let img = placeDict["img"] as! String
                    let name = placeDict["name"] as! String
                    let calories = placeDict["calories"] as! Int
                    let description = placeDict["description"] as! String
                    let fid = placeDict["id"] as! String
                    foods.append(FoodModel(id: fid, imgURL: img, name: name,calorieCount:calories,isFavourite: true,description: description))
                }
            }
            completionBlock(foods)
        }
        
    }
    
    
    func logOut(){
        try! Auth.auth().signOut();
    }
}
