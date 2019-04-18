//
//  BetterSnapCollectionViewController.swift
//  AppStore
//
//  Created by Robin He on 3/14/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class BetterSnapCollectionViewController : UICollectionViewController{
    
    
    init(){
        
        let layout = SnapCollectionViewLayOut()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

class SnapCollectionViewLayOut : UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        

        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        
        // because u need to calculate the offset according to the collectionView.contenInset, therefor u need to set collectionView.contentInset in view did load instead of insetForSectionat collectionview function,which has the same function to set distance between scroll View edge and contentView (safe area)
        
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        
        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
        
        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    
}
