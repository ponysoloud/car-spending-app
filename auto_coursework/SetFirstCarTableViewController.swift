//
//  SetFirstCarTableViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 08.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class SetFirstCarTableViewController: UITableViewController {

    @IBOutlet weak var startUsingButton: UIButton!
    
    @IBOutlet weak var hintLabel: CustomLabel!
    
    
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var modelLabel: UILabel!
    
    @IBOutlet weak var generationLabel: UILabel!
    
    @IBOutlet weak var serieLabel: UILabel!
    
    var index: Int?
    
    var returnedData: String?
    
    override func viewDidLoad() {
        
        //UIApplication.shared.statusBarStyle = .lightContent
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsetsMake(-statusBarHeight, 0, 0, 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        hintLabel.setLineHeight(value: 3.5)
        
        let buttonLayer = startUsingButton.layer
        buttonLayer.cornerRadius = 8
        
        buttonLayer.shadowColor = UIColor.black.cgColor
        buttonLayer.shadowOpacity = 0.05
        buttonLayer.shadowOffset = CGSize(width: 0, height: 0)
        buttonLayer.shadowRadius = 2.0
        startUsingButton.clipsToBounds = false

        startUsingButtonState(isHidden: true)
        
        if let i = index {
            DataSource.updateData(updatedIndex: i, data: returnedData!)
        }
        
        brandLabel.text = DataSource.currentBrand
        modelLabel.text = DataSource.currentModel
        generationLabel.text = DataSource.currentGeneration
        serieLabel.text = DataSource.currentSerie
        
        if let text = serieLabel.text {
            if text != "" {
                startUsingButtonState(isHidden: false)
            }
        }
    }
    
    func startUsingButtonState(isHidden: Bool) {
        startUsingButton.isHidden = isHidden
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tappedButtonIndex: Int = Int(segue.identifier ?? "0")!
        
        // get a reference to the second view controller
        let predictiveVC = segue.destination as! PredictiveTextFieldViewController
        
        // set a variable in the second view controller with the String to pass
        predictiveVC.senderIndex = tappedButtonIndex
    }
    
    @IBAction func startUsing(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "entryVC")
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}
