//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Robin He on 3/13/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class AppsHorizontalController: BetterSnapCollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "cellId"
    
    var socialGroup = [SocialResult]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeaderDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 12 , left: 16, bottom: 0, right: 16)
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderDetailCell
        cell.socialGroup = socialGroup[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    
    
}
