//
//  RatingCell.swift
//  AppStore
//
//  Created by Robin He on 3/17/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class RatingCell: UICollectionViewCell {
    
    var result : ReviewDetail? {
        
        didSet{
            
            title.text = result?.title.label
            username.text = result?.author.name.label
            content.text = result?.content.label
            
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9411764706, blue: 0.9725490196, alpha: 1)
        let stackView = VerticalStackView(arrangeView: [
            UIStackView(arrangedSubviews: [
                title,
                
                username
                ],customedSpacing: 8),
            rating,
            content
            
            ], spacing: 12
        )
        title.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 20, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let title = UILabel(text: "Bestgame ever", font: 15,numberOfLine: 1)
    let username = UILabel(text: "Alsacasc", font: 15,numberOfLine: 1)
    let rating = UILabel(text: "rating", font: 12)
    let content = UILabel(text: "content\ncontent\ncontent\ncontent", font: 15)
}
