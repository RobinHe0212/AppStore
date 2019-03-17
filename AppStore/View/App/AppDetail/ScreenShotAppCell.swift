//
//  ScreenShotAppCell.swift
//  AppStore
//
//  Created by Robin He on 3/17/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class ScreenShotAppCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(previewLabel)
        addSubview(screenshot.view)
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
        screenshot.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    let previewLabel = UILabel(text: "Preview", font: 18)
    let screenshot = ScreenshotCollectionVC()
    
    
}

