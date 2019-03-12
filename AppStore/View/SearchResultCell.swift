//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Robin He on 3/11/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    
    
    var search : Result? {
        
        didSet{
            
            if let track = search?.trackName {
                appTitle.text = track
  
            }
            if let desc = search?.primaryGenreName{
                appDes.text = desc
            }
            if let rating = search?.averageUserRating{
                appSize.text = String(rating)
            }
            if let iconImage = search?.artworkUrl512{
                icon.sd_setImage(with: URL(string: iconImage), completed: nil)
            }
            if let screenShot = search?.screenshotUrls{
                
                screenshotImage1.sd_setImage(with: URL(string: screenShot[0]), completed: nil)
                if screenShot.count > 1 {
                    screenshotImage2.sd_setImage(with: URL(string: screenShot[1]), completed: nil)
                    if screenShot.count > 2 {
                        screenshotImage3.sd_setImage(with: URL(string: screenShot[2]), completed: nil)
                    }
                }
            }
            
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(stackOverAll)
        stackOverAll.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let icon : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.cornerRadius = 14
        image.layer.masksToBounds = true
        image.heightAnchor.constraint(equalToConstant: 64).isActive = true
        image.widthAnchor.constraint(equalToConstant: 64).isActive = true
        return image

    }()
    
    let appTitle : UILabel = {
        
        let label = UILabel()
        label.text = "APP NAME"
        return label
        
    }()
    
    let appDes : UILabel = {
        
        let label = UILabel()
        label.text = "Photos&Videos"

        return label
        
    }()
    
    let appSize : UILabel = {
        
        let label = UILabel()
        label.text = "9.87M"

        return label
        
    }()
    
    let addBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 16
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        return btn
        
        
    }()
    
    
    
    lazy var stackInfo : UIStackView = {
        
        let stack = UIStackView(arrangedSubviews: [self.icon,VerticalStackView(arrangeView: [self.appTitle,self.appDes,self.appSize]),self.addBtn])
        stack.spacing = 12
        stack.alignment = .center
        
        return stack
        
    }()
    
    
    lazy var screenshotImage1 = self.createScreenShotImage()
    lazy var screenshotImage2 = self.createScreenShotImage()
    lazy var screenshotImage3 = self.createScreenShotImage()

    
    fileprivate func createScreenShotImage() -> UIImageView {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.cornerRadius = 9
        image.clipsToBounds = true
        image.layer.borderWidth = 0.8
        image.layer.borderColor = UIColor(white: 0.8, alpha: 0.5).cgColor
        return image
        
    }
    
    
    lazy var stackScreenShot : UIStackView = {
        
        let stack = UIStackView(arrangedSubviews: [self.screenshotImage1,self.screenshotImage2,self.screenshotImage3])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
        
        
    }()
    
    lazy var stackOverAll : UIStackView = {
        
        let stack = VerticalStackView(arrangeView: [self.stackInfo,self.stackScreenShot], spacing: 12)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
        
    }()
    
}
