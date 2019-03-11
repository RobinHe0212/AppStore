//
//  VerticalStackView.swift
//  AppStore
//
//  Created by Robin He on 3/11/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {

    init(arrangeView:[UIView],spacing:CGFloat = 0){
        
        super.init(frame: .zero)
        arrangeView.forEach({
            
            addArrangedSubview($0)
           
            
        })
        self.spacing = spacing
        self.axis = .vertical
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
