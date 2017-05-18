//
//  CarIndex.swift
//  auto_coursework
//
//  Created by Matvey Kravtsov on 15/05/2017.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import Foundation

class CarIndex {
    var meanConsumption: Double = 0
    var deviationConsumption: Double = 0
    
    init (json: [String: Any]) {
        
        if let meanConsumption = json["m_consumption"] as? Double {
            self.meanConsumption = meanConsumption
        }
        
        if let deviationConsumption = json["d_consumption"] as? Double {
            self.deviationConsumption = deviationConsumption
        }
    }
    
    func toDictionary() -> [String: Any] {
        
        let json : [String: Any] =
            [
                "m_consumption":meanConsumption,
                "d_consumption":deviationConsumption
            ]
        
        return json
    }
}
