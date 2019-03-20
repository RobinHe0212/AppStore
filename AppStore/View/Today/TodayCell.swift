//
//  TodayCell.swift
//  AppStore
//
//  Created by Robin He on 3/20/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let image = UIImageView(image: "garden", angle: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.addSubview(image)
        image.centerInSuperview(size: .init(width: 200, height: 200))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
