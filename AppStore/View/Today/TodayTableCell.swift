//
//  TodayTableCell.swift
//  AppStore
//
//  Created by Robin He on 3/20/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class TodayTableCell: UITableViewCell {

    let label = UILabel(text: "Document", font: 16)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        label.fillSuperview(padding: .init(top: 40, left: 12, bottom: 0, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
