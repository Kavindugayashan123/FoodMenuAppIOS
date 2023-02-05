//
//  UserModel.swift
//  FoodMenuApp
//
//

import Foundation
struct UserModel: Identifiable {
    var id: String = UUID().uuidString
    var rid: Int
    var name: String
    var email: String
    var phone: String
}
