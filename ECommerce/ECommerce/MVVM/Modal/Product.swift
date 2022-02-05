//
//  Product.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import CoreData

extension Product {
    class func fetch(ids: [String], completion: ((Bool, [Product]?, String?)->Void)) {
        let managedContext = CoreDataStack.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<Product>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "id IN %@", ids)
        
        do {
            let arrayProducts = try managedContext.fetch(fetchRequest)
            completion(true, arrayProducts, nil)
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
    
    func save() {
        CoreDataStack.shared.saveMainContext()
    }
    
    //Only for Demo purpose
    class func addDemoEntries () {
        let images = ["https://tinyurl.com/y4f5e96j",
                      "https://tinyurl.com/y2szwrys",
                      "https://tinyurl.com/y4bfj5b7",
                      "https://tinyurl.com/y44marw5",
                      "https://tinyurl.com/y4urobx8",
                      "https://tinyurl.com/y2yhf95n",
                      "https://tinyurl.com/y5n467o3",
                      "https://tinyurl.com/yxupqdll"]
        for (index, imageUrl) in images.enumerated() {
            let managedContext = CoreDataStack.shared.managedObjectContext
            
            let desc = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)
            let product = Product(entity: desc!, insertInto: managedContext)
            
            product.name = "Product\(index)"
            product.imageUrl = imageUrl
            product.id = "\(index)"
            
            for user in [UserType.Type1, UserType.Type2, UserType.Type3] {
                //add Discount for all userType
                let managedContext = CoreDataStack.shared.managedObjectContext
                
                let desc = NSEntityDescription.entity(forEntityName: "Discount", in: managedContext)
                let discount = Discount(entity: desc!, insertInto: managedContext)
                
                discount.product = product.id
                discount.userType = user.description
                discount.discount = Double(Int.random(in: 25...75)) //It can be based on userType
                discount.save()
            }
            product.save()
        }
    }
}
