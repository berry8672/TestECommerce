//
//  Banner.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import CoreData

extension Banner {
    class func fetchRandomBanner(completion: ((Bool, DashboardBanner?, String?)->Void)) {
        let managedContext = CoreDataStack.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<Banner>(entityName: "Banner")
        
        do {
            let totalresults = try managedContext.count(for: fetchRequest)
            if totalresults > 0 {
                // randomlize offset
                fetchRequest.fetchOffset = Int.random(in: 0..<totalresults)
                fetchRequest.fetchLimit = 1

                let banner = try managedContext.fetch(fetchRequest)
                completion(true, DashboardBanner(imageUrl: banner.first?.imageUrl ?? ""), nil)
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

    //Only For Demo Purpose
    class func addDemoEntries () {
        let images = ["https://tinyurl.com/y379jw6s",
                      "https://tinyurl.com/y3pjtea4",
                      "https://tinyurl.com/y2gersqn",
                      "https://tinyurl.com/y3c6ksu5",
                      "https://tinyurl.com/y4k2klen",
                      "https://tinyurl.com/y3pccdrc",
                      "https://tinyurl.com/y26fn9rm"]
        
        for (index, image) in images.enumerated() {
            let managedContext = CoreDataStack.shared.managedObjectContext
            
            let desc = NSEntityDescription.entity(forEntityName: "Banner", in: managedContext)
            let banner = Banner(entity: desc!, insertInto: managedContext)
            
            banner.imageUrl = image
            banner.id = "\(index)"
            banner.save()
        }
    }
}
