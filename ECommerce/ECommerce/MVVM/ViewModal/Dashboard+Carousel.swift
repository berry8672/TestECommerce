//
//  Dashboard+Carousel.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation

struct DashboardCarousel {
    var imageUrl: String!
    
    static func fetchCarousel (successBlock: @escaping ([DashboardCarousel])->Void, failureBlock: @escaping (String)->Void) {
        Carousel.fetchCarousel { success, carousels, errorMessage in
            if let carousels = carousels, success == true {
                successBlock(carousels)
            } else {
                failureBlock(errorMessage ?? "No Banner Found")
            }
        }
    }
}
