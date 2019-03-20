//
//  ExtensionHelp.swift
//  AppStore
//
//  Created by Robin He on 3/17/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews:[UIView],customedSpacing:CGFloat){
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customedSpacing
    }
    
}


extension UILabel {
    
    convenience init(text:String,font:CGFloat,numberOfLine:Int = 0){
        self.init(frame: .zero)
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: font)
        self.numberOfLines = numberOfLine
    }
    
    
}

extension UIImageView {
    
    convenience init(image:String,angle:CGFloat){
        self.init(image: nil)
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = angle
        self.contentMode = .scaleAspectFill
        self.image = UIImage(named: image)
        
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
