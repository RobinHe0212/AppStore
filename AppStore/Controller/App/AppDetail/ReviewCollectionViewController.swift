//
//  ReviewCollectionViewController.swift
//  AppStore
//
//  Created by Robin He on 3/17/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class ReviewCollectionViewController: BetterSnapCollectionViewController, UICollectionViewDelegateFlowLayout {

    let ratingCellId = "cellId"
    
    var reviewDetail : [ReviewDetail]?{
        
        didSet{
            
            self.collectionView.reloadData()
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(RatingCell.self, forCellWithReuseIdentifier: ratingCellId)
        collectionView.contentInset = .init(top: 0, left: 12, bottom: 20, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ratingCellId, for: indexPath) as! RatingCell
        if let review = reviewDetail {
            cell.result = review[indexPath.item]
        }
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewDetail?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width-32, height: self.view.frame.height)
    }
}
