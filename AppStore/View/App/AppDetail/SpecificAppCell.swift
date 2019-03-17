//
//  SpecificAppCell.swift
//  AppStore
//
//  Created by Robin He on 3/17/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit
import SDWebImage

class SpecificAppCell: UICollectionViewCell {
    
    
    var appResult : DetailedResult? {
        
        didSet{
            
            iconImage.sd_setImage(with: URL(string: appResult?.artworkUrl60 ?? ""), completed: nil)
            title.text = appResult?.trackName
            new.text = appResult?.releaseNotes
        }
        
    }
    
    let iconImage = UIImageView(image: "", angle: 16)
    let title = UILabel(text: "app title", font: 20)
    let newTitle = UILabel(text: "What's new", font: 18)
    let new = UILabel(text: "What's new", font: 13)
    let buyBtn = UIButton(name: "Free")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconImage.constrainWidth(constant: 100)
        iconImage.constrainHeight(constant: 100)
        let stackView = VerticalStackView(arrangeView: [
            
            UIStackView(arrangedSubviews: [
                iconImage,
                VerticalStackView(arrangeView: [
                    title,
                    UIStackView(arrangedSubviews: [
                         buyBtn,
                         UIView()
                        ])
                   
                    
                    ], spacing: 12)
                
                ],customedSpacing:12),
            newTitle,
            new
            
            ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 0, right: 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
