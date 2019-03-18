//
//  ReviewAppCell.swift
//  AppStore
//
//  Created by Robin He on 3/17/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class ReviewAppCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reviewTitle)
        addSubview(reviewCV.view)
        
        reviewTitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
        reviewCV.view.anchor(top: reviewTitle.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let reviewTitle = UILabel(text: "Reviews & Ratings", font: 18)
    let reviewCV = ReviewCollectionViewController()
}
