//
//  dataTableView.swift
//  SnapkitTest
//
//  Created by jamesChen on 2019/1/2.
//  Copyright © 2019年 jamesChen. All rights reserved.
//

import Foundation
import UIKit

class dataTableViewController: UITableViewController {
    
    let cellItem = "cellItem"
    
    var number = 0
    
    
    override func viewDidLoad() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellItem)
        tableView.tableFooterView = UIView()

    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellItem)
        
        cell?.textLabel?.text = "\(indexPath.row)"
        
        return cell!
    }
}
