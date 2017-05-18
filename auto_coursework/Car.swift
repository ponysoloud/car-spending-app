//
//  Car.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 04.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import Foundation

class Car {
    
    var mark: String = ""
    var model: String = ""
    var descr: String = ""
    var image: String = ""
    var index: CarIndex?
    var status: CarStatus?
    var measurements: [Measurement] = []
    
    init (json: [String:Any]) {
        
        if let descr = json["description"] as? String {
            self.descr = descr
        }
        
        if let image = json["image"] as? String {
            self.image = image
        }
        
        if let mark = json["mark"] as? String {
            self.mark = mark
        }
        
        if let model = json["model"] as? String {
            self.model = model
        }
        
        if let index = json["index"] as? [String: Any] {
            self.index = CarIndex(json: index)
        }
        
        if let status = json["status"] as? [String: Any] {
            self.status = CarStatus(json: status)
        }
        
        if let measurements = json["measurements"] as? [[String: Any]] {
            self.measurements = [Measurement]()
            for m in measurements {
                self.measurements.append(Measurement(json: m))
            }
        }
    }
    
    init(mark: String, model: String) {
        self.mark = mark
        self.model = model
    }
    
    func getName() -> String {
        return "\(mark) \(model)"
    }
    
    func toDictionary() -> [String: Any] {

        let json : [String: Any] =
            [
                "mark":mark,
                "model":model,
                "description":descr,
                "image":image,
                "index": index?.toDictionary() ?? "",
                "status": status?.toDictionary() ?? "",
                "measurements": Measurement.toDictionary(array: measurements)
            ]

        return json
    }
}

