//
//  User+Login.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import CoreData

class LoginUser {
    var name: String!
    var id: String!
    var userType: String!
    
    static var currentUser: LoginUser! {
        get {
            if let data = UserDefaults.standard.value(forKey: "kUserDetails") as? Data, let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as? [String: String] {
                return LoginUser(details: dict)
            }
            return nil
        } set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: "kUserDetails")
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.set(try! JSONSerialization.data(withJSONObject: newValue.dictValues(), options: .fragmentsAllowed), forKey: "kUserDetails")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    init() {
        
    }
    
    init(details: [String: String]) {
        self.name = details["name"]
//        self.username = details["username"]
//        self.password = details["password"]
        self.userType = details["userType"]
        self.id = details["id"]
    }
    
    func dictValues () -> [String: String] {
        var details = [String: String]()
        details["name"] = self.name
//        details["username"] = self.username
//        details["password"] = self.password
        details["userType"] = self.userType
        details["id"] = self.id
        return details
    }
    
    class func login (userName: String, password: String, successBlock: @escaping (LoginUser) -> Void, failureBlock: @escaping (String) -> Void) {
        User.fetchUser(userName: userName, password: password) { success, user, errorMessage in
            if let user = user {
                successBlock(user)
            } else {
                failureBlock(errorMessage ?? "User Not Found")
            }
        }
    }
}
