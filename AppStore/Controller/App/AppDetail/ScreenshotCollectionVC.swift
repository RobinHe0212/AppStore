//
//  ScreenshotCollectionVC.swift
//  AppStore
//
//  Created by Robin He on 3/17/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class ScreenshotCollectionVC : BetterSnapCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var appResult : DetailedResult?{
        
        didSet{
            
            self.collectionView.reloadData()
            
        }
        
    }
    
    class ScreenshotCell : UICollectionViewCell {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .white
            self.layer.cornerRadius = 12
            self.layer.masksToBounds = true
            addSubview(screenImage)
            screenImage.fillSuperview()
        }
        let screenImage = UIImageView(image: "", angle: 12)
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotCell
        let urlString = appResult?.screenshotUrls[indexPath.item]
        cell.screenImage.sd_setImage(with: URL(string: urlString ?? ""), completed: nil)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width-120, height: self.view.frame.height)
    }
    
}
