//
//  TodayTableView.swift
//  AppStore
//
//  Created by Robin He on 3/20/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit

class TodayTableView: UITableViewController {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.register(TodayTableCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.item == 0 {
            
            let cell = UITableViewCell()
            let today = TodayCell()
            cell.addSubview(today)
            today.centerInSuperview(size: .init(width: 250, height: 250))
            return cell
        }
        let cell = TodayTableCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}
