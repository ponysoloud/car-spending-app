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
        
        topCell.detailTextLabel?.text = DataSource.userCar.getName()
        
        donateCellLabel.setLineHeight(value: 3.5)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let alertController = UIAlertController(title: "Внимание", message: "Вы хотите стереть все данные?", preferredStyle: .actionSheet)
            let DestructiveAction = UIAlertAction(title: "Стереть", style: .destructive) {
                (result : UIAlertAction) -> Void in
                
                AppDelegate.shared?.resetApp()
                
            }
            
            let okAction = UIAlertAction(title: "Отмена", style: .default) {
                (result : UIAlertAction) -> Void in
  
            }
            
            alertController.addAction(DestructiveAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
