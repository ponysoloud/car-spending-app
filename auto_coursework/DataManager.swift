//
//  DataManager.swift
//  auto_coursework
//
//  Created by Matvey Kravtsov on 14/05/2017.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import Foundation
import Alamofire

class DataManager {
    
    private class func request(url:String, method: HTTPMethod, parameters: Parameters?, completion: @escaping (Dictionary<String,Any>) -> Void){
        Alamofire.request("https://car-app-service.herokuapp.com/" + url, method: method, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            //debugPrint(response)
            
            if let result = response.result.value {
                let JSON = result as! Dictionary<String, Any>
                completion(JSON)
            }
        }
    }
    
    class func getCarMarks(completion: @escaping (Array<String>) -> Void){
        DataManager.request(url: "car", method: .get, parameters: nil) { json in
            
            let arr = json["marks"] as! Array<String>
            completion(arr)
        }
    }
    
    class func getCarModels(mark: String, completion: @escaping (Array<String>) -> Void){
        DataManager.request(url: "car/"+mark, method: .get, parameters: nil) { json in
            
            let arr = json["models"] as! Array<String>
            completion(arr)
        }
    }
    
    class func getCarInfo(mark:String, model: String, completion: @escaping (Car) -> Void){
        DataManager.request(url: "car/"+mark+"/"+model, method: .get, parameters: nil) { json in
            
            let car = Car(json: json)
            completion(car)
        }
    }
    
    class func getCarIndex(mark:String, model: String, completion: @escaping (CarIndex) -> Void){
        DataManager.request(url: "car/index/"+mark+"/"+model, method: .get, parameters: nil) { json in
            
            let carIndex = CarIndex(json: json)
            completion(carIndex)
        }
    }
    
    class func getCarPriorIndex(mark:String, model: String, completion: @escaping (CarIndex) -> Void){
        DataManager.request(url: "car/prior_index/"+mark+"/"+model, method: .get, parameters: nil) { json in
            
            let carIndex = CarIndex(json: json)
            completion(carIndex)
        }
    }
    
    class func sendConsumption(mark:String, model: String, consumption: Double, completion: @escaping (CarIndex) -> Void){
        DataManager.request(url: "car/index/"+mark+"/"+model, method: .post, parameters: ["consumption":consumption]) { json in
            
            let carIndex = CarIndex(json: json)
            completion(carIndex)
        }
    }
    
    class func getCarStatus(mark:String, model: String, consumption: Double, completion: @escaping (CarStatus) -> Void){
        DataManager.request(url: "car/status/"+mark+"/"+model, method: .post, parameters: ["consumption":consumption]) { json in
            
            let carStatus = CarStatus(json: json)
            completion(carStatus)
        }
    }
    
    class func setCarInfo(mark:String, model: String, descr: String?, image: String?, completion: @escaping (String) -> Void = {_ in }){
        let parameters: Parameters = [
            "description": descr ?? 0,
            "image": image ?? 0
        ]
        
        DataManager.request(url: "car/"+mark+"/"+model, method: .post, parameters: parameters) { json in
            
            let status: String = json["status"] as! String
            completion(status)
        }
    }
    
    class func setCarPriorIndex(mark:String, model: String, meanConsumption: Double, completion: @escaping (String) -> Void = {_ in }){
        DataManager.request(url: "car/prior_index/"+mark+"/"+model, method: .post, parameters: ["consumption":meanConsumption]) { json in
            
            let status: String = json["status"] as! String
            completion(status)
        }
    }
    
    /*
     private class func convertToDictionary(text: String) -> [String: Any]? {
     if let data = text.data(using: .utf8) {
     do {
     return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
     } catch {
     print(error.localizedDescription)
     }
     }
     return nil
     }
     */
    
    /*
    class func GET(){
        Alamofire.request("http://localhost:5000/car").responseJSON { response in
            //debugPrint(response)
            
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                print("JSON: \(JSON["marks"] ?? "none")")
            }
        }
        let parameters: Parameters = [
            "consumption": 10
        ]
        
        Alamofire.request("http://localhost:5000/car/status/Audi/80", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
    }
 */
    
}
