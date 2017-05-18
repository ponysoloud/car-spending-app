//
//  CarStatus.swift
//  auto_coursework
//
//  Created by Matvey Kravtsov on 15/05/2017.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import Foundation

class CarStatus {
    var message: String
    var pLevel: Double
    
    init (json: [String: Any]) {
        message = json["car_status"] as! String
        pLevel = json["p_level"] as! Double
    }
    
    func toDictionary() -> [String: Any] {
        
        let json : [String: Any] =
            [
                "car_status":message,
                "p_level":pLevel
            ]
        
        return json
    }
}
