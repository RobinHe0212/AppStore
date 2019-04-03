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
    }
    
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
