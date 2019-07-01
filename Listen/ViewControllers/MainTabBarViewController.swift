//
//  MainTabBarViewController.swift
//  Listen
//
//  Created by Bashir Sentongo on 01/04/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().prefersLargeTitles = true
        view.backgroundColor = .white
        tabBar.tintColor = .purple
        setUpViewControllers()
    }
    
    //MARK:- Set Up Functions
    
    private func setUpViewControllers() {
        self.viewControllers = [
            generateNavigationController(with: PodcastsSearchViewController(), title: "Search", image: UIImage(named: "search")!),
            generateNavigationController(with: ViewController(), title: "Favorites", image: UIImage(named: "favorites")!),
            generateNavigationController(with: ViewController(), title: "Downloads", image: UIImage(named: "downloads")!)
        ]
    }

    
    //MARK:- Helper Functions
    
    private func generateNavigationController(with pRootViewController: UIViewController, title pTitle: String, image pImage: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: pRootViewController)
        pRootViewController.navigationItem.title = pTitle
        navController.tabBarItem.title = pTitle
        navController.tabBarItem.image = pImage
        return navController
    }
}
