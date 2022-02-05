//
//  Dashboard+Product.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import MapKit

class DashboardProduct {
    var name: String!
    var id: String!
    var imageUrl: String!
    var discount: Double!
    
    init(product: Product, discount: Discount?) {
        self.name = product.name
        self.id = product.id
        self.imageUrl = product.imageUrl
        self.discount = discount?.discount ?? 0.0
    }
    
    var discountString: String? {
        get {
            if discount > 0 {
                return "Min \(Int(discount!))% off"
            }
            return nil
        }
    }
    
    class func fetchProducts (successBlock: @escaping ([DashboardProduct])->Void, failureBlock: @escaping (String)->Void) {
        Discount.discountProducts(userType: LoginUser.currentUser.userType, completion: { success, products, errorMessage in
            if let products = products, success == true {
                successBlock(products)
            } else {
                failureBlock(errorMessage ?? "No Products Found")
            }
        })
    }
}
