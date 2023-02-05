//
//  FoodModel.swift
//  FoodMenuApp
//
//

import Foundation
struct FoodModel:Identifiable {
    var id: String =  UUID().uuidString
    var imgURL: String
    var name: String
    var calorieCount:Int
    var isFavourite: Bool
    var description :String;
}
