//
//  TodayMultiCell.swift
//  AppStore
//
//  Created by Robin He on 3/27/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class TodayMultiCell: BaseCell {
    
    override var todayResult : TodayModel?{
        didSet{
          title.text = todayResult?.title
        subTitle.text = todayResult?.subTitle
            
        }
        
    }
    
    
    let title = UILabel(text: "LIFE HACK", font: 20)
    let subTitle = UILabel(text: "Utilizing your Time", font: 22)
    
    
    var topConstraint : NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        let uiCollectionVC = MultiCenterCollectionViewController()

        let stackView = VerticalStackView(arrangeView: [
            title,
            subTitle,
            uiCollectionVC.view
            
            ], spacing: 8)
        addSubview(stackView)
        
        // before or after dismiss popUp View. contentInset should be change ,therefore we change topconstraint
        //        stackView.fillSuperview(padding: .init(top: 50, left: 24, bottom: 24, right: 24))
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint?.isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
