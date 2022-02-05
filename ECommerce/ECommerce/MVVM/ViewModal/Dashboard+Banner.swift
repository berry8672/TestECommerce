//
//  Dashboard+Banner.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation

struct DashboardBanner {
    var imageUrl: String!
    
    static func fetchBanner (successBlock: @escaping (DashboardBanner)->Void, failureBlock: @escaping (String)->Void) {
        Banner.fetchRandomBanner(completion: { success, banner, errorMessage in
            if let banner = banner, success == true {
                successBlock(banner)
            } else {
                failureBlock(errorMessage ?? "No Banner Found")
            }
        })
    }
}
