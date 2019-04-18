//
//  TodayTableView.swift
//  AppStore
//
//  Created by Robin He on 3/20/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class TodayTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            self.tableView.isScrollEnabled = false
            self.tableView.isScrollEnabled = true

        }
        
        
            if scrollView.contentOffset.y > 100 {
                if self.floatingContainerView.transform == .identity {
                
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                    
                    self.floatingContainerView.transform = .init(translationX: 0, y: -90 - UIApplication.shared.statusBarFrame.height)
                }, completion: nil)
                }
            }else {
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                    
                    self.floatingContainerView.transform = .identity
                }, completion: nil)
                
            }
            
            
        
        
        
        
    }
    
    
    let tableView = UITableView(frame: .zero, style: .plain)
    var result : TodayModel?
    
    
    var dismissHeader : (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.addSubview(tableView)
        view.clipsToBounds = true
        tableView.fillSuperview()
        setUpCloseBtn()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(floatingContainerView)
        floatingContainerView.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: -90, right: 10), size: .init(width: 0, height: 90))
        setUpFloatingView()
        
    }
    
    fileprivate func setUpFloatingView(){
        
        let image = UIImageView()
        image.constrainWidth(constant: 65)
        image.constrainHeight(constant: 65)
        image.image = result?.image
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15)
        title.text = result?.title
        let subTitle = UILabel()
        subTitle.font = UIFont.systemFont(ofSize: 12)
        subTitle.text = result?.subTitle
        let btn = UIButton(name: "Get")
        
        
        let stackView = UIStackView(arrangedSubviews:
            [
                image,
                VerticalStackView(arrangeView:
                    [
                        title,
                        subTitle
                    
                    ]
                    
                    , spacing: 5),
                btn
            
            ]
            
            
            , customedSpacing: 10)
        stackView.alignment = .center
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(blurEffectView)
        blurEffectView.fillSuperview()
        floatingContainerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
     
        
    }
    

    
    
    let floatingContainerView : UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        return view
        
    }()
    
    
    
    
    fileprivate func setUpCloseBtn(){
        
        view.addSubview(closeBtn)
        closeBtn.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 20), size: .init(width: 40, height: 80))
    }
    
    lazy var closeBtn : UIButton = {
        
        let close = UIButton(type: .system)
        close.setImage(UIImage(named: "close_button"), for: .normal)
        close.tintColor = .lightGray
        close.addTarget(self, action: #selector(tapcloseBtn), for: .touchUpInside)

        return close
        
    }()
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.item == 0 {
            let cell = TodayFullScreenHeaderCell()
            
            cell.today.todayResult = result
            
            
           return cell
        }
        
        return TodayTableCell()
    }
    
    @objc func tapcloseBtn(button:UIButton){
        button.isHidden = true
        dismissHeader?()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.item == 0 {
            return 450
        }else {
            return UITableView.automaticDimension
        }
        
        
    }
}
