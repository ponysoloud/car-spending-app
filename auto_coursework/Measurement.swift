//
//  Measurement.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 18.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import Foundation

class Measurement {
    
    var range: Double
    var fuel: Double
    var cost: Double
    var date: Date = Date()
    
    init (range: Double, fuel: Double, cost: Double) {
        self.range = range
        self.fuel = fuel
        self.cost = cost
        self.date = Date()
    }
    
    init (json: [String: Any]) {
        range = json["range"] as! Double
        fuel = json["fuel"] as! Double
        cost = json["cost"] as! Double
        
        if let date = json["date"] as? TimeInterval {
            self.date = Date(timeIntervalSince1970: date)
        }
    }
    
    func toDictionary() -> [String: Any] {
        
        let json : [String: Any] =
            [
                "range":range,
                "fuel":fuel,
                "cost": cost,
                "date": date.timeIntervalSince1970
            ]
        
        return json
    }
    
    class func toDictionary(array:[Measurement]) -> [[String:Any]] {
        var arr = [[String:Any]]()
        for m in array {
            arr.append(m.toDictionary())
        }
        return arr
    }

    
}
