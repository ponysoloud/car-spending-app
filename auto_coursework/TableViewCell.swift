//
//  TableViewCell.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 04.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var shadowed: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.reuseIdentifier != "no separator" {
            var insets: CGFloat
            
            insets = CGFloat(integerLiteral: Int(self.reuseIdentifier ?? "0")!)
            
            if !shadowed {
                let line = EdgeShadowLayer(forView: self, edge: .Bottom, shadowRadius: 1, toColor: UIColor(red:0.89, green:0.89, blue:0.91, alpha:1.00), fromColor: UIColor(red:0.89, green:0.89, blue:0.91, alpha:1.00), opacity: 1, insets: insets)
            
                self.layer.addSublayer(line)
            }
        }
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.05
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2.0
        self.clipsToBounds = false
    }
    
}
