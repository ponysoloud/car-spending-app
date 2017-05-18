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
        let m = Measurement(range: (tableView!.stateArray[0] as NSString).doubleValue,
                            fuel: (tableView!.stateArray[1] as NSString).doubleValue,
                            cost: (tableView!.stateArray[2] as NSString).doubleValue)
        DataSource.addUserData(measurement: m)
        tableView!.rangeField.text = ""
        tableView!.petrolField.text = ""
        tableView!.moneyField.text = ""
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Embed Segue" {
            let destinationVC = segue.destination as! AddInfoTableViewController
            destinationVC.parentView = self
            self.tableView = destinationVC
        }
    }
    
}
