//
//  AppDelegate.swift
//  ECommerce
//
//  Created by Berlin Raj on 05/02/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        UserDefaults.standard.set(nil, forKey: "kUserDetails")
//        UserDefaults.standard.set(false, forKey: "kHaveInitialValues")
//        UserDefaults.standard.synchronize()
        // Override point for customization after application launch.
        
        if UserDefaults.standard.bool(forKey: "kHaveInitialValues") == false {
            addInitialDemoValues()//Only for Demo purpose
            UserDefaults.standard.set(true, forKey: "kHaveInitialValues")
            UserDefaults.standard.synchronize()
        }
        
        checkAutoLogin()
        
        return true
    }
    
    func checkAutoLogin () {
        if window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        if LoginUser.currentUser == nil {
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "kLoginViewController") as! LoginViewController
            self.window?.rootViewController = loginVC
            self.window?.makeKeyAndVisible()
        } else {
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let dashboardVC = storyBoard.instantiateViewController(withIdentifier: "kDashboardViewController") as! DashboardViewController
            self.window?.rootViewController = dashboardVC
            self.window?.makeKeyAndVisible()
        }
    }
    
    //Only for Demo purpose
    func addInitialDemoValues() {
        User.addDemoEntries()
        Product.addDemoEntries()
        Banner.addDemoEntries()
        Carousel.addDemoEntries()
    }
}

