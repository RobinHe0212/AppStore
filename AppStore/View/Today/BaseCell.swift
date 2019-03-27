//
//  BaseCell.swift
//  AppStore
//
//  Created by Robin He on 3/27/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    var todayResult : TodayModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
