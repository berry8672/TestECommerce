//
//  Discount.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import CoreData

extension Discount {
    class func discountProducts(userType: String, completion: ((Bool, [DashboardProduct]?, String?)->Void)) {
        let managedContext = CoreDataStack.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<Discount>(entityName: "Discount")
        fetchRequest.predicate = NSPredicate(format: "userType == %@", userType)
        
        do {
            let arrayDiscounts = try managedContext.fetch(fetchRequest)
            let trimmedDiscounts = arrayDiscounts.prefix(4)
            Product.fetch(ids: trimmedDiscounts.map({ discount in
                return discount.product!
            })) { success, products, errorMessage in
                if success {
                    var dashboardProducts = [DashboardProduct]()
                    for product in products! {
                        dashboardProducts.append(DashboardProduct(product: product, discount: trimmedDiscounts.first(where: { disc in
                            return disc.product == product.id
                        })))
                    }
                    completion(true, dashboardProducts, nil)
                } else {
                    completion(false, nil, errorMessage)
                }
            }
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
}
