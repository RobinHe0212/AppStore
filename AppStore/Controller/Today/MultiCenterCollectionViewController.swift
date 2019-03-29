//
//  MultiCenterCollectionViewController.swift
//  AppStore
//
//  Created by Robin He on 3/27/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class MultiCenterCollectionViewController: BaseViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MultipleInsideCell.self, forCellWithReuseIdentifier: cellId)

        
    }
    let cellId = "cellId"
    
    var result : [AppContent]?
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleInsideCell
        cell.cellResult = self.result?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4,result?.count ?? 0)
    }
    fileprivate let spacing : CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = self.collectionView.frame.height
        
        let height = (CGFloat(collectionViewHeight) - spacing*3)/4
        return .init(width: self.view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
}
