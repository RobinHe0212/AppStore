//
//  AppRowCell.swift
//  AppStore
//
//  Created by Robin He on 3/12/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text:String,font:CGFloat){
        self.init(frame: .zero)
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: font)
       
    }
    
    
}

extension UIImageView {
    
    convenience init(image:String,angle:CGFloat){
        self.init(image: nil)
        self.backgroundColor = .purple
        self.clipsToBounds = true
        self.layer.cornerRadius = angle
        self.contentMode = .scaleAspectFill
        self.constrainWidth(constant: 64)
        self.constrainHeight(constant: 64)
        
    }
    
}

extension UIButton {
    
    convenience init(name:String){
        self.init(type: .system)
        self.setTitle(name, for: .normal)
        self.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        self.setTitleColor(UIColor.blue, for: .normal)
        self.constrainWidth(constant: 82)
        self.constrainHeight(constant: 32)
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
    }
    
}

class AppRowCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = UIStackView(arrangedSubviews: [icon,VerticalStackView(arrangeView: [nameLabel,companyLabel]),addBtn])
        addSubview(stackView)
        stackView.fillSuperview()
        stackView.spacing = 10
        stackView.alignment = .center
    }
    
    let icon = UIImageView(image: "", angle: 12)
    let nameLabel = UILabel(text: "NameLabel", font: 15)
    let companyLabel = UILabel(text: "CompanyLabel", font: 12)
    let addBtn = UIButton(name: "Add")
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
