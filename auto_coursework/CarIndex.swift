//
//  CarIndex.swift
//  auto_coursework
//
//  Created by Matvey Kravtsov on 15/05/2017.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import Foundation

class CarIndex {
    var meanConsumption: Double
    var deviationConsumption: Double
    
    init (json: Dictionary<String, Any>) {
        meanConsumption = json["m_consumption"] as! Double
        deviationConsumption = json["d_consumption"] as! Double
    }
}
