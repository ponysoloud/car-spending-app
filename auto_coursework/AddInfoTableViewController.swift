//
//  AddInfoTableViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 05.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class AddInfoTableViewController: UITableViewController, UITextFieldDelegate {
    
    var parentView: AddInfoViewController?
    
    // Section 1
    @IBOutlet weak var autoCell: TableViewCell!
    
    // Section 2
    @IBOutlet weak var rangeCell: TableViewCell!
    
    @IBOutlet weak var petrolCell: UITableViewCell!
    
    @IBOutlet weak var moneyCell: TableViewCell!
    
    var currentCar: Int?
    
    var currentTextField: UITextField? {
        didSet {
            switch currentTextField?.placeholder {
            case "Текущий километраж"?:
                textFieldSuffix = "км"
                currentIndex = 0
                
            case "Литров топлива заправлено"?:
                textFieldSuffix = "л"
                currentIndex = 1
                
            case "Цена за литр топлива"?:
                textFieldSuffix = "руб"
                currentIndex = 2
                
            default:
                textFieldSuffix = ""
                
            }
        }
    }
    
    var textFieldSuffix: String?
    
    var currentIndex: Int?
    
    var stateArray = ["", "", ""] {
        didSet {
            var count = 0
            for i in stateArray {
                if i != "" {
                    count += 1
                }
            }
            
            if count == 3 {
                // show button
                parentView?.saveButtonState(isHidden: false)
            } else {
                // hide button
                parentView?.saveButtonState(isHidden: true)
            }
        }
    }
    
    let nondecimalCharacters : CharacterSet = {
        let locale = Locale.current
        let separator = locale.decimalSeparator ?? "."
        var dd = NSCharacterSet(charactersIn: "0123456789" + separator).inverted
        return dd
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoCell.setShadow()
        autoCell.textLabel?.text = DataSource.getCurrentCar().name
        autoCell.selectionStyle = UITableViewCellSelectionStyle.none
        currentCar = 0
        
        rangeCell.setShadow()
        moneyCell.setShadow()
    }
    
    
    
    // Actions--------------------------------------
    
    @IBAction func addSuffix(_ sender: Any) {
        if let textField = currentTextField, let index = currentIndex  {
            // Set the text FIeld state
            stateArray[index] = textField.text ?? ""
            
            if textField.text != "" {
                textField.text = "\(textField.text ?? "") \(textFieldSuffix ?? "")"
            }
        }
        
        currentTextField = nil
    }
    
    @IBAction func changeCurrentTextField(_ sender: Any) {
        currentTextField = sender as? UITextField
        removeSuffix(targetTextField: currentTextField!)
        print("changeTF")
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        if let textField = currentTextField {
            textField.resignFirstResponder()
        }
    }
    
    func removeSuffix(targetTextField: UITextField!) {
        if targetTextField.text != "" {
            let spaceIndex = targetTextField.text?.range(of: " ")
            let temp = targetTextField.text?.substring(to: (spaceIndex?.lowerBound)!)
            targetTextField.text = temp
        }
    }
    
    
    // Set sections header color
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(red:0.56, green:0.60, blue:0.74, alpha:1.00)
    }
    
    
    // Реализация функции унаследованной от протокола UITextFieldDelegate, для предотвращения написания чего либо
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        let replacementTextHasNonDecimals = string.rangeOfCharacter(from: nondecimalCharacters)
        
        // Предотвращение написания не цифровых символов
        if replacementTextHasNonDecimals != nil {
            return false
        }
        
        // Предотвращение написания второй точки
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
        
    }
    
}
