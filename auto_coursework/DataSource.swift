//
//  DataSource.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 04.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import Foundation
import UIKit

class DataSource {
    
    public static var userCar = Car(mark: "", model: "")
    
    public static var consumption: Double?
    
    static func saveCar() {
        UserDefaults.standard.set(userCar.toDictionary(), forKey: "CurrentCar")
        UserDefaults.standard.synchronize()
    }
    
    static func removeCar() {
        userCar = Car(mark: "", model: "")
        UserDefaults.standard.removeObject(forKey: "CurrentCar")
        UserDefaults.standard.synchronize()
    }
    
    static func createCar(completion: @escaping ()->() = {}) {
        
        DataManager.setUser(data: userCar)
        saveCar()
        
        updateCarInfo {
            completion()
        }
        /*
        loadCarIndex()
        loadCarInfo()
        loadCarStatus()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: {
            completion()
        })

 */
    }
    
    static func updateCarInfo(completion: @escaping ()->() = {}) {
        recalcMean()
        
        loadCarIndex()
        loadCarInfo()
        loadCarStatus()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: {
            completion()
        })
    }
    
    static func loadCar(completion: @escaping ()->() = {}) -> Bool {
        
        if let json = UserDefaults.standard.value(forKey: "CurrentCar") as?  [String:Any]  {
            userCar = Car(json: json)
            /*
            DataManager.getUser(completion: { (name, data) in
                userCar.measurements = data
            })
 */
            
            updateCarInfo {
                completion()
            }
            
            return true
        }
        return false
    }
    
    static func loadCarStatus(completion: @escaping ()->() = {}) {
        guard let c = consumption else { return }
        
        DataManager.getCarStatus(mark: userCar.mark, model: userCar.model, consumption: c) { carStatus in
            userCar.status = carStatus
            saveCar()
            completion()
        }
    }
    
    static func loadCarIndex(completion: @escaping ()->() = {}) {
        DataManager.getCarIndex(mark: userCar.mark, model: userCar.model) { carIndex in
            userCar.index = carIndex
            saveCar()
            completion()
        }
    }
    
    static func loadCarInfo() {
        DataManager.getCarInfo(mark: userCar.mark, model: userCar.model) { car in
            userCar.descr = car.descr
            userCar.image = car.image
            saveCar()
        }
    }
    
    static func sendConsumption() {
        guard let c = consumption else { return }
        
        DataManager.sendConsumption(mark: userCar.mark, model: userCar.model, consumption: c) { carIndex in
            userCar.index = carIndex
            saveCar()
        }
    }
    
    static func addUserData(measurement: Measurement) {
        userCar.measurements.append(measurement)
        DataManager.setUser(data: userCar)
        recalcMean()
        saveCar()
        sendConsumption()
        
        //print("mean: \(consumption ?? -1)")
    }
    
    private static func recalcMean() {
        var cons = 0.0
        let mArr = userCar.measurements
        for (i, m) in mArr.enumerated() {
            if i == 0 { continue }
            let range = m.range - mArr[i - 1].range
            cons += (m.fuel / range) * 100
        }
        if mArr.count > 1 {
            cons /= Double(mArr.count - 1)
            consumption = cons
        }
    }
    
}
