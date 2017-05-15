//
//  DataSource.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 04.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class DataSource {
    
    static let carStore: CarStore! = CarStore()
    
    static func getCurrentCar() -> Car {
        return DataSource.carStore.carsContainer[0]
    }
    
    static var carBrands = ["Toyota", "Audi", "Aston Martin", "Acura", "Mercedes"]
    
    static var carModels = ["A320", "333", "45 Mas", "Corolla", "Mercedes"]
    
    static var carGenerations = ["1997-2006", "2010", "45 Mas", "Corolla", "Mercedes"]
    
    static var carSeries = ["a1923"]
    
    static var currentBrand: String?
    
    static var currentModel: String?
    
    static var currentGeneration: String?
    
    static var currentSerie: String?
    
    static func updateData(updatedIndex: Int, data: String) {
            switch updatedIndex {
            case 0:
                currentBrand = data
                currentModel = ""
                currentGeneration = ""
                currentSerie = ""
            case 1:
                currentModel = data
                currentGeneration = ""
                currentSerie = ""
            case 2:
                currentGeneration = data
                currentSerie = ""
            default:
                currentSerie = data
            }
    }
    
    static func returnData(index: Int) -> [String] {
        switch index {
        case 0:
            return carBrands
        case 1:
            return carModels
        case 2:
            return carGenerations
        default:
            return carSeries
        }
    }
    
    static func instantiateCar(brand: String, model: String, generation: String, serie: String) {
        // ОТправка на сервер данных - создание объекта и тд
        
    }
    
    static func getUserConsumption() -> Double {
        return 3
    }
    
    static func getUserDispersion() -> Double {
        return 1
    }
    
    static func getUserExpectedValue() -> Double {
        return 0
    }
}
