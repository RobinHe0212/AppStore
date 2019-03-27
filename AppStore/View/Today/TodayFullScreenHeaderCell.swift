//
//  TodayFullScreenHeaderCell.swift
//  AppStore
//
//  Created by Robin He on 3/25/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class TodayFullScreenHeaderCell: UITableViewCell {

    
    
    let today = TodayCell()
    lazy var closeBtn : UIButton = {
        
        let close = UIButton(type: .system)
        close.setImage(UIImage(named: "close_button"), for: .normal)
        
        return close
        
    }()
    
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(today)
        today.fillSuperview()
       
        addSubview(closeBtn)
        
        closeBtn.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 0, bottom: 0, right: 20),size: .init(width: 80, height: 40))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
