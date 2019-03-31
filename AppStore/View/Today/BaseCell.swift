//
//  BaseCell.swift
//  AppStore
//
//  Created by Robin He on 3/27/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    var todayResult : TodayModel!
    
    
    override var isHighlighted: Bool{
        
        
        didSet {
            
            var transform = CGAffineTransform.identity
            
            if isHighlighted {
                print("highlighted is \(isHighlighted)")
               transform = .init(scaleX: 0.9, y: 0.9)
            
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.transform = transform
                
            }, completion: nil)
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundView = UIView()
        backgroundView?.backgroundColor = .white
        backgroundView?.layer.cornerRadius = 16
        addSubview(backgroundView!)
        
        backgroundView?.layer.shadowRadius = 10
        backgroundView?.layer.shadowOpacity = 0.1
        backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
        backgroundView?.layer.shouldRasterize = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
