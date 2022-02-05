//
//  Banner.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import CoreData

extension Carousel {
    class func fetchCarousel(completion: ((Bool, [DashboardCarousel]?, String?)->Void)) {
        let managedContext = CoreDataStack.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<Carousel>(entityName: "Carousel")
        
        do {
            let arrayCarousels = try managedContext.fetch(fetchRequest)
            completion(true, arrayCarousels.map({ carousel in
                return DashboardCarousel(imageUrl: carousel.imageUrl)
            }), nil)
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

    //Only For Demo Purpose
    class func addDemoEntries () {
        let images = ["https://tinyurl.com/y3w8oaah",
                      "https://tinyurl.com/y4vaulog",
                      "https://tinyurl.com/y3j7rq6g",
                      "https://tinyurl.com/y28jpmyr",
                      "https://tinyurl.com/y2w7fbdo",
                      "https://tinyurl.com/yy2f6lha"]
        
        for (index, image) in images.enumerated() {
            let managedContext = CoreDataStack.shared.managedObjectContext
            
            let desc = NSEntityDescription.entity(forEntityName: "Carousel", in: managedContext)
            let carousel = Carousel(entity: desc!, insertInto: managedContext)
            
            carousel.imageUrl = image
            carousel.id = "\(index)"
            carousel.save()
        }
    }
}
