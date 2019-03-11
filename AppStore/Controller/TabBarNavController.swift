//
//  ViewController.swift
//  AppStore
//
//  Created by Robin He on 3/11/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class TabBarNavController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewControllers = [
            setUpTabController(title: "Search", vc: SearchViewController(), image: "search"),
            setUpTabController(title: "Today", vc: UIViewController(), image: "today_icon"),
            setUpTabController(title: "App", vc: UIViewController(), image: "apps")
        ]
        
    }

    fileprivate func setUpTabController(title:String,vc:UIViewController,image:String) -> UIViewController{
        
    
        let navController = UINavigationController(rootViewController: vc)
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: image)
        vc.navigationItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        return navController
        
    }

}

