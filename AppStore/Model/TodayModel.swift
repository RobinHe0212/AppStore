//
//  TodayModel.swift
//  AppStore
//
//  Created by Robin He on 3/25/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

struct TodayModel {
    
    let title : String
    let subTitle : String
    let image : UIImage
    let desc : String
    let bgc : UIColor
    
    let cellType : CellEnum
    
    enum CellEnum : String {
        case singleCell,MultiCell
    }
    
}
