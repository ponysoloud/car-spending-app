//
//  Car.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 04.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import Foundation

class Car {
    
    var name: String!
    var descr: String = ""
    var image: String = ""
    var index: CarIndex?
    
    init (json: Dictionary<String, Any>) {
        descr = json["description"] as! String
        image = json["image"] as! String
    }
    
    init(name: String) {
        self.name = name
    }
}

