//
//  DataManager.swift
//  auto_coursework
//
//  Created by Matvey Kravtsov on 14/05/2017.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import Foundation
import Alamofire
import Firebase

class DataManager {
    
    public static var token : String?
    public static var isLogged : Bool {
        get {
            return Auth.auth().currentUser != nil
        }
    }
    private static let endpoint : String = "https://car-app-service.herokuapp.com/"
    
    private class func request(url:String, method: HTTPMethod, parameters: Parameters?, completion: @escaping (Dictionary<String,Any>) -> Void){
        
        let urlAll = endpoint + url
        print("request: " + urlAll)
        
        Alamofire.request(urlAll, method: method, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            //debugPrint(response)
            
            if let result = response.result.value {
                let JSON = result as? Dictionary<String, Any>
                completion(JSON ?? [String:Any]())
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
    
    class func signup(email:String, password:String, completion: @escaping (String) -> Void = {_ in }){
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        DataManager.request(url: "signup", method: .post, parameters: parameters) { json in
            
            let token: String? = json["idToken"] as? String
            DataManager.token = token
            
            completion(token != nil ? "OK" : "ERROR")
        }
    }
    
    class func login(email:String, password:String, completion: @escaping (String) -> Void = {_ in }){
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        DataManager.request(url: "login", method: .post, parameters: parameters) { json in

            let token: String? = json["idToken"] as? String
            DataManager.token = token
            
            completion(token != nil ? "OK" : "ERROR")
        }
    }
    
    class func setUser(name:String, completion: @escaping (String) -> Void = {_ in }){
        if (!isLogged) {
            return
        }
        
        DataManager.request(url: "user?token="+token!, method: .post, parameters: ["info":["name":name]]) { json in
            
            completion("OK")
        }
    }
    
    class func setUser(data:Car, completion: @escaping (String) -> Void = {_ in }){
        if (!isLogged) {
            return
        }
    
        DataManager.request(url: "user?token="+token!, method: .post, parameters:
            [
                "info":
                [
                    "car" :
                    [
                        "mark":data.mark,
                        "model":data.model,
                        "measurements":Measurement.toDictionary(array: data.measurements)
                    ]
                ]
            ]
                ) { json in
            
            completion("OK")
        }
    }
    
    class func getUser(completion: @escaping (String, Car) -> Void = {_ in }){
        if (!isLogged) {
            return
        }
        
        DataManager.request(url: "user?token="+token!, method: .get, parameters: nil) { json in
            
            if (json["error"] != nil) {
                completion("", Car(mark: "", model: ""))
                return
            }
            
            let info = json["info"] as! [String:Any]
            
            var name = ""
            if (info["name"] != nil) {
                name = info["name"] as! String
            }
            
            var car = Car(mark: "", model: "")
            if (info["car"] != nil) {
                car = Car(json: info["car"] as! [String:Any])
            }
            
            completion(name, car)
        }
    }
    
}
