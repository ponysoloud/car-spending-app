//
//  CustomLabel.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 03.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    // Set label line height
    func setLineHeight(value: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = value
        
        let attrString = NSMutableAttributedString(string: self.text!)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        self.attributedText = attrString
        self.textAlignment = NSTextAlignment.center
    }
    
    
}
