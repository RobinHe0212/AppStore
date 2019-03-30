//
//  BackSwipeController.swift
//  AppStore
//
//  Created by Robin He on 3/30/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class BackSwipeController : UINavigationController, UIGestureRecognizerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
    
}
