//
//  AppsHeaderDetailCell.swift
//  AppStore
//
//  Created by Robin He on 3/13/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class AppsHeaderDetailCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        image.backgroundColor = .red
        
        contentLabel.numberOfLines = 2
        let stackView = VerticalStackView(arrangeView: [nameLabel,contentLabel,image], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel = UILabel(text: "Facebook", font: 12)
    let contentLabel = UILabel(text: "Keeping up with friends is faster than ever", font: 24)
    let image = UIImageView(image: "", angle: 8)
    
}
