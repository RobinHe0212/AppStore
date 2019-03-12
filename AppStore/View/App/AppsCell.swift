//
//  AppsCell.swift
//  AppStore
//
//  Created by Robin He on 3/12/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit




class AppsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.addSubview(appSection)
        appSection.anchor(top: self.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 10, left: 16, bottom: 0, right: 0))
        self.addSubview(horizontalController.view)
        horizontalController.view.anchor(top: appSection.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    
    }
    let appSection = UILabel(text: "App Section", font: 20)

    let horizontalController = HorizontalViewController()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
