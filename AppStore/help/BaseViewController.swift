//
//  BaseViewController.swift
//  AppStore
//
//  Created by Robin He on 3/12/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class BaseViewController: UICollectionViewController {


    init(){
        super.init(collectionViewLayout:UICollectionViewFlowLayout())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
