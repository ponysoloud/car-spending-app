//
//  ConsumptionCell.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 18.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class ConsumptionCell: UITableViewCell {
    
    @IBOutlet weak var rangeLabel: UILabel!

    @IBOutlet weak var fuelLabel: UILabel!

    @IBOutlet weak var costLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    
    func setCell(m: Measurement) {
        rangeLabel.text = String(format: "%.0f км", m.range)
        fuelLabel.text = String(format: "%.0f л", m.fuel)
        costLabel.text = String(format: "%.0f руб", m.cost * m.fuel)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        
        dateLabel.text = dateFormatter.string(from: m.date)
    }
}

