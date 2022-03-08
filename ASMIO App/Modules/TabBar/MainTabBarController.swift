//
//  MainTabBarController.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            createHomeNavigationController(),
            createCategoryNavigationController(),
            createCartNavigationController(),
            createDealsNavigationController(),
            createProfileNavigationController()
        ]
        configureTabBar()
        selectedIndex = 1
    }
    
    func configureTabBar() {
        tabBar.backgroundColor = UIColor.tabBarBackground
        tabBar.tintColor = UIColor.greenColor
        tabBar.layer.cornerRadius = 6
        tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07).cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 1
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.masksToBounds = false
    }
    
    func createHomeNavigationController() -> UINavigationController{
        let homeViewController = UIViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Explore", image: #imageLiteral(resourceName: "Home"), tag: 0)
        let navigationController =  UINavigationController(rootViewController: homeViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }

    func createCategoryNavigationController() -> UINavigationController {
        let categoryViewController = CategoriesViewController()
        categoryViewController.tabBarItem = UITabBarItem(title: "Categories", image: #imageLiteral(resourceName: "Categories"), tag: 1)
        let navigationController =  UINavigationController(rootViewController: categoryViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }

    func createCartNavigationController() -> UINavigationController {
        let cart:UIViewController = UIViewController()
        cart.tabBarItem = UITabBarItem(title: "My Cart", image: #imageLiteral(resourceName: "Cart"), tag: 2)
        let navigationController =  UINavigationController(rootViewController: cart)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
    
    func createDealsNavigationController() -> UINavigationController {
        let offersViewController:UIViewController = UIViewController()
        offersViewController.tabBarItem = UITabBarItem(title: "Deals", image: #imageLiteral(resourceName: "Deals"), tag: 3)
        let navigationController =  UINavigationController(rootViewController: offersViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
    
    func createProfileNavigationController() -> UINavigationController {
        let wishlistViewController = UIViewController()
        wishlistViewController.tabBarItem = UITabBarItem(title: "Me", image: #imageLiteral(resourceName: "Me"), tag: 4)
        let navigationController =  UINavigationController(rootViewController: wishlistViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
    
}
