//
//  AppsHorizontalCell.swift
//  AppStore
//
//  Created by Robin He on 3/13/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class AppsHorizontalCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(appsHorizontalVC.view)
        appsHorizontalVC.view.fillSuperview()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let appsHorizontalVC = AppsHorizontalController()
    
    
}
