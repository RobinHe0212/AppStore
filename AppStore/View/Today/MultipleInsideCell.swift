//
//  MultipleInsideCell.swift
//  AppStore
//
//  Created by Robin He on 3/27/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class MultipleInsideCell: UICollectionViewCell {
    
    
    var cellResult : AppContent? {
        
        didSet{
            icon.sd_setImage(with: URL(string: cellResult?.artworkUrl100 ?? "") , completed: nil)
            nameLabel.text = cellResult?.name
            companyLabel.text = cellResult?.artistName
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = UIStackView(arrangedSubviews: [icon,VerticalStackView(arrangeView: [nameLabel,companyLabel]),addBtn])
        icon.constrainHeight(constant: 64)
        icon.constrainWidth(constant: 64)
        addSubview(stackView)
        stackView.fillSuperview()
        stackView.spacing = 10
        stackView.alignment = .center
    }
    
    let icon = UIImageView(image:"star", angle: 12)
    let nameLabel = UILabel(text: "NameLabel", font: 15)
    let companyLabel = UILabel(text: "CompanyLabel", font: 12)
    let addBtn = UIButton(name: "Add")
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
