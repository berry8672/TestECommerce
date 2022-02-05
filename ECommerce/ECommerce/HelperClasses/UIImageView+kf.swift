//
//  UIImageView+kf.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String, animated: Bool = true) {
        guard let url = URL(string: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {
            return
        }
        if animated {
            let activityIndicator = self.activityIndicatorView()
            activityIndicator.startAnimating()
            self.addSubview(activityIndicator)
        }
//        let processor = DownsamplingImageProcessor(size: self.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 20)
        self.kf.setImage(with: Source.network(ImageResource(downloadURL: url))) { result, error in
            if animated {
                let activityIndicator = self.activityIndicatorView()
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    func activityIndicatorView() -> UIActivityIndicatorView {
        if let view = self.subviews.first(where: { (subview) -> Bool in
            return subview.isKind(of: UIActivityIndicatorView.self)
        }) {
            return view as! UIActivityIndicatorView
        }
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicatorView.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        return activityIndicatorView
    }
}
