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
           for (index,view) in ratingStackView.arrangedSubviews.enumerated() {
            let label = result!.rating.label
            if let ratingInt = Int(label) {
                 view.alpha = index >= ratingInt ? 0:1
            }
           
            
            }
            
        }
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9411764706, blue: 0.9725490196, alpha: 1)
        username.textColor = UIColor.gray.withAlphaComponent(0.8)
        let stackView = VerticalStackView(arrangeView: [
            UIStackView(arrangedSubviews: [
                title,
                
                username
                ],customedSpacing: 8),
            UIStackView(arrangedSubviews: [
                ratingStackView,UIView()
                ]),
            content
            
            ], spacing: 12
        )
        title.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 12, left: 12, bottom: 0, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let title = UILabel(text: "Bestgame ever", font: 15,numberOfLine: 1)
    let username = UILabel(text: "Alsacasc", font: 12,numberOfLine: 1)
    
    let ratingStackView : UIStackView = {
        
        var arrangeStackView = [UIView]()

        (0..<5).forEach{_ in
            let image = UIImageView(image: UIImage(named: "star"))
            image.constrainWidth(constant: 24)
            image.constrainHeight(constant: 24)
                arrangeStackView.append(image)
                
            }
            
        let rating = UIStackView(arrangedSubviews: arrangeStackView)
        return rating
        
        
    }()
    let content = UILabel(text: "content\ncontent\ncontent\ncontent", font: 12,numberOfLine: 4)
}
