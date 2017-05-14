//
//  PredictiveTextFieldViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 10.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class PredictiveTextFieldViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var saveButton: UIButton!
    
    enum SenderType: String {
        case brand = "Марка"
        case model = "Модель"
        case generation = "Поколение"
        case serie = "Серия"
    }
    
    var senderIndex: Int! {
        
        didSet {
            switch senderIndex {
            case 0:
                senderType = SenderType.brand
            case 1:
                senderType = SenderType.model
            case 2:
                senderType = SenderType.generation
            default:
                senderType = SenderType.serie
                
            }
        }
    }
    
    var senderType: SenderType?
    
    @IBOutlet weak var textFieldView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var autoComplete = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonLayer = saveButton.layer
        buttonLayer.cornerRadius = 8
        
        buttonLayer.shadowColor = UIColor.black.cgColor
        buttonLayer.shadowOpacity = 0.05
        buttonLayer.shadowOffset = CGSize(width: 0, height: 0)
        buttonLayer.shadowRadius = 2.0
        saveButton.clipsToBounds = false
        
        saveButtonState(isHidden: true)
        
        let line = EdgeShadowLayer(forView: textFieldView, edge: .Bottom, shadowRadius: 1.5, toColor: UIColor(red:0.56, green:0.60, blue:0.74, alpha:1.00), fromColor: UIColor(red:0.56, green:0.60, blue:0.74, alpha:1.00), opacity: 0.6)
        textFieldView.layer.addSublayer(line)
    }
    
    func saveButtonState(isHidden: Bool) {
        saveButton.isHidden = isHidden
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationController?.navigationBar.topItem?.title = senderType?.rawValue ?? "Тестинг"
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func searchAutocompleteEntriesWithSubstring(substring: String) {
        autoComplete.removeAll(keepingCapacity: false)
        
        for key in DataSource.returnData(index: senderIndex) {
            let myStringL: NSString! = key.lowercased() as NSString
            
            let substringRange: NSRange! = myStringL.range(of: substring.lowercased())
            
            if substringRange.location == 0 {
                autoComplete.append(key)
            }
        }
        
        tableView.reloadData()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        searchAutocompleteEntriesWithSubstring(substring: substring)
        
        //return true
        
        
        // Force all characters to be uppercase, no matter what.
        let lowercaseCharacters = NSCharacterSet.lowercaseLetters
        if string.rangeOfCharacter(from: lowercaseCharacters) != nil {
            let uppercaseString = string.uppercased()
            if (textField.text?.isEmpty)! {
                // Updates return button; forces cursor to the end
                textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: uppercaseString)
            } else {
                // Preserves cursor location; doesn't update return button
                let beginning = textField.beginningOfDocument
                let start = textField.position(from: beginning, offset: range.location)!
                let end = textField.position(from: start, offset: range.length)!
                let range = textField.textRange(from: start, to: end)
                textField.replace(range!, withText: uppercaseString)
            }
            return false
        } else {
            return true
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        let index = indexPath.row as Int
        
        cell.textLabel!.text = autoComplete[index]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)!
        
        textField.text = selectedCell.textLabel!.text!.uppercased()
        
        clearTable()
        
        saveButtonState(isHidden: false)
        
        textField.resignFirstResponder()
    }
    
    func clearTable() {
        autoComplete.removeAll()
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get a reference to the second view controller
        let setFirstCarVC = segue.destination as! SetFirstCarTableViewController
        
        // set a variable in the second view controller with the String to pass
        
        setFirstCarVC.index = senderIndex
        let inputData: String = textField.text!
        setFirstCarVC.returnedData = inputData.capitalizedFirst()
    }
    
}

extension String {
    func capitalizedFirst() -> String {
        let first = self[self.startIndex ..< self.index(startIndex, offsetBy: 1)]
        let rest = self[self.index(startIndex, offsetBy: 1) ..< self.endIndex]
        return first.uppercased() + rest.lowercased()
    }
    
    func capitalizedFirst(with: Locale?) -> String {
        let first = self[self.startIndex ..< self.index(startIndex, offsetBy: 1)]
        let rest = self[self.index(startIndex, offsetBy: 1) ..< self.endIndex]
        return first.uppercased(with: with) + rest.lowercased(with: with)
    }
}
