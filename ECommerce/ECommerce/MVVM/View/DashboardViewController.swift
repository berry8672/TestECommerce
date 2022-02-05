//
//  DashboardViewController.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import UIKit
import Carousel

class DashboardViewController: UIViewController {

    @IBOutlet weak var viewCarousel: CarouselView!
    @IBOutlet weak var collectionViewProducts: UICollectionView!
    @IBOutlet weak var bannerView: UIImageView!
    
    var arrayProducts: [DashboardProduct]!
    var arrayCarousel: [DashboardCarousel]!
    var banner: DashboardBanner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchProducts()
        self.fetchCarousels()
        self.fetchBanner()
    }
    
    func fetchProducts () {
        DashboardProduct.fetchProducts { products in
            self.arrayProducts = products
            self.collectionViewProducts.reloadData()
        } failureBlock: { errorMessage in
            print("Products:", errorMessage)
        }
    }
    
    func fetchCarousels () {
        DashboardCarousel.fetchCarousel { carousels in
            self.arrayCarousel = carousels
            self.updateCarousel()
        } failureBlock: { errorMessage in
            print("Carousels:", errorMessage)
        }
    }
    
    func updateCarousel () {
        for (index, carousel) in self.arrayCarousel.enumerated() {
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: CGFloat(index) * viewCarousel.frame.width, y: 0), size: viewCarousel.frame.size))
            imageView.clipsToBounds = true
            imageView.contentMode = UIView.ContentMode.scaleAspectFill
            imageView.setImage(url: carousel.imageUrl, animated: false)
            self.viewCarousel.addSubview(imageView)
        }
    }
    
    func fetchBanner() {
        DashboardBanner.fetchBanner { banner in
            self.banner = banner
            self.bannerView.setImage(url: self.banner.imageUrl)
        } failureBlock: { errorMessage in
            print("Banners:", errorMessage)
        }
    }
    
    @IBAction func buttonLogoutAction () {
        LoginUser.currentUser = nil
        (UIApplication.shared.delegate as? AppDelegate)?.checkAutoLogin()
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayProducts == nil ? 0 : self.arrayProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kProductCell", for: indexPath) as! DashboardProductCell
        cell.config(product: self.arrayProducts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-10)/2, height: (collectionView.frame.height-10)/2)
    }
}
