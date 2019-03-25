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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(today)
        today.centerInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
