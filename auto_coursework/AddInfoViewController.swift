//
//  AddInfoViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 21.04.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class AddInfoViewController: UIViewController {

    var tableView: AddInfoTableViewController?
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        saveButtonState(isHidden: true)
    }
    
    func saveButtonState(isHidden: Bool) {
        saveButton.isHidden = isHidden
    }
    
    @IBAction func saveData(_ sender: Any) {
        DataSource.addUserData(range: tableView!.stateArray[0], fueld: tableView!.stateArray[1])
        tableView!.rangeField.text = ""
        tableView!.petrolField.text = ""
        tableView!.moneyField.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Embed Segue" {
            let destinationVC = segue.destination as! AddInfoTableViewController
            destinationVC.parentView = self
            self.tableView = destinationVC
        }
    }
    
}
