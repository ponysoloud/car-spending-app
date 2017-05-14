//
//  UserSettingsViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 02.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class UserSettingsViewController: UITableViewController {
    
    @IBOutlet weak var topCell: TableViewCell!
    
    @IBOutlet weak var bottomCell: TableViewCell!
    
    @IBOutlet weak var donateCellLabel: CustomLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topCell.setShadow()
        bottomCell.setShadow()
        
        topCell.detailTextLabel?.text = DataSource.getCurrentCar().name
        
        donateCellLabel.setLineHeight(value: 3.5)
    }
    
    
}
