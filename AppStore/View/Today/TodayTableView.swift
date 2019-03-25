//
//  TodayTableView.swift
//  AppStore
//
//  Created by Robin He on 3/20/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class TodayTableView: UITableViewController {
    
    
    var result : TodayModel?
    
    
    var dismissHeader : (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.item == 0 {
            let cell = TodayFullScreenHeaderCell()
            
            cell.today.todayResult = result
            cell.closeBtn.addTarget(self, action: #selector(tapcloseBtn), for: .touchUpInside)
            
            
           return cell
        }
        
        return TodayTableCell()
    }
    
    @objc func tapcloseBtn(button:UIButton){
        button.isHidden = true
        dismissHeader?()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.item == 0 {
            return 450
        }else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
        
        
    }
}
