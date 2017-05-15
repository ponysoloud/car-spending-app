//
//  CarStatus.swift
//  auto_coursework
//
//  Created by Matvey Kravtsov on 15/05/2017.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import Foundation

class CarStatus {
    var status: String
    var pLevel: Double
    
    init (json: Dictionary<String, Any>) {
        status = json["car_status"] as! String
        pLevel = json["p_level"] as! Double
    }
}
