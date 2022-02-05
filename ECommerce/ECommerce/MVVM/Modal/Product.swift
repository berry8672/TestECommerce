//
//  Product.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import CoreData

extension Product {
    class func fetchProducts(completion: ((Bool, [Product]?, String?)->Void)) {
        let managedContext = CoreDataStack.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<Product>(entityName: "Product")
        
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
}
