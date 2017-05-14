//
//  GreetingViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 05.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class GreetingViewController: UIViewController {
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var greetingLabel: CustomLabel!
    
    var tableView:  SetFirstCarTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greetingLabel.setLineHeight(value: 3.5)
        
        
        let buttonLayer = continueButton.layer
        buttonLayer.cornerRadius = 8
        
        buttonLayer.shadowColor = UIColor.black.cgColor
        buttonLayer.shadowOpacity = 0.05
        buttonLayer.shadowOffset = CGSize(width: 0, height: 0)
        buttonLayer.shadowRadius = 2.0
        continueButton.clipsToBounds = false
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Embed Segue" {
            let destinationVC = segue.destination as! SetFirstCarTableViewController
            destinationVC.parentView = self
            self.tableView = destinationVC
        }
    }*/
    
}
