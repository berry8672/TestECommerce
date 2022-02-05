//
//  User.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import CoreData

enum UserType: Int {
    case Type1 = 0, Type2, Type3
    
    var description: String {
        switch self {
        case .Type1: return "type1"
        case .Type2: return "type2"
        case .Type3: return "type3"
        }
    }
}

extension User {
    class func fetchUser(userName: String, password: String, completion: @escaping ((Bool, LoginUser?, String?)->Void)) {
        let managedContext = CoreDataStack.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", userName, password)
        
        do {
            let arrayUser = try managedContext.fetch(fetchRequest)
            completion(true, arrayUser.first?.user(), nil)
        } catch let error as NSError {
            completion(false, nil, error.localizedDescription)
        }
    }
    
    class func delete (_ product: NSManagedObject?) {
        if let product = product {
            let context = CoreDataStack.shared.managedObjectContext
            context.delete(product)
            do {
                try context.save()
            } catch {
                print("Deletion Failed: \(error.localizedDescription)")
            }
        }
    }
    
    func user() -> LoginUser {
        let user = LoginUser()
        user.name = self.name
        user.id = self.id
        user.userType = self.userType
        return user
    }
    
    func save() {
        CoreDataStack.shared.saveMainContext()
    }
    
    //Only for Demo purpose
    class func addDemoEntries () {
        for index in 1...5 {
            let managedContext = CoreDataStack.shared.managedObjectContext
            
            let desc = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
            let user = User(entity: desc!, insertInto: managedContext)
            
            user.name = "Name\(index)"
            user.username = "user\(index)"
            user.password = "\(index)"
            user.userType = UserType(rawValue: index%3)?.description ?? "type1"
            user.id = "\(index)"
            user.save()
        }
    }
}
