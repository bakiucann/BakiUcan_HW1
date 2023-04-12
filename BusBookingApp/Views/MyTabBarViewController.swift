//
//  TabBarViewController.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 10.04.2023.
//

import UIKit

class MyTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Tab Bar görünümü özelleştirme
        tabBar.barTintColor = .white
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .gray

        // Tab Bar öğeleri ve görünümü ayarlama
        let firstVC = UINavigationController(rootViewController: MainMenuViewController())
        firstVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "house"), tag: 0)


        
        
        viewControllers = [firstVC]
    }
}
