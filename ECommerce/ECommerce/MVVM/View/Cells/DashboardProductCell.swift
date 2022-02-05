//
//  DashboardProductCell.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import UIKit

class DashboardProductCell: UICollectionViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDiscount: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func config(product: DashboardProduct) {
        self.labelName.text = product.name
        self.labelDiscount.text = product.discountString
        self.imageView.setImage(url: product.imageUrl)
    }
}
