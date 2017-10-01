//
//  AppDelegate.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 20.04.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    
    static var shared : AppDelegate?
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func resetApp(shouldDeleteData: Bool) {
        print ("reset app")
        
        
        if (DataManager.isLogged)
        {
            if (shouldDeleteData) {
                DataManager.setUser(data: Car(mark: "", model: ""), completion: { (status) in
                    self.signOut()
                })
            } else {
                signOut()
            }
        }
        
        DataSource.consumption = nil
        
        DataSource.removeCar()
        
        let storyboard = UIStoryboard(name: "FirstEntry", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        self.window?.rootViewController = vc
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        // Example usage of DataManager
        /*
        DataManager.getCarMarks { (marks) in
            print(marks)
        }
        
        DataManager.getCarModels(mark: "Audi") { (models) in
            print(models)
        }
        
        DataManager.getCarInfo(mark: "Audi", model: "80") { car in
            print(car.descr)
            print(car.image)
        }
        
        DataManager.getCarIndex(mark: "Audi", model: "80") { carIndex in
            print(carIndex.meanConsumption)
            print(carIndex.deviationConsumption)
        }
        
        DataManager.getCarStatus(mark: "Audi", model: "80", consumption: 13) { carStatus in
            print(carStatus.status)
            print(carStatus.pLevel)
        }
        
        DataManager.sendConsumption(mark: "Audi", model: "80", consumption: 15) { carIndex in
            print(carIndex.meanConsumption)
            print(carIndex.deviationConsumption)
        }
        
        DataManager.setCarInfo(mark: "Audi", model: "80", descr: nil, image: "some_image.png") { status in
            print(status)
        }
        
        DataManager.getCarPriorIndex(mark: "Audi", model: "80") { carIndex in
            print(carIndex.meanConsumption)
            print(carIndex.deviationConsumption)
        }
        
        DataManager.setCarPriorIndex(mark: "Audi", model: "80", meanConsumption: 12) { status in
            print(status)
        }
         */
        
        AppDelegate.shared = self
        
        
        if (DataSource.loadCar()) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            self.window?.rootViewController = vc
        }
        
        if (DataManager.isLogged) {
            Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
                DataManager.token = token
            })
        }
        
        UINavigationBar.appearance().shadowImage = UIImage ()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        return true
    }
    
    func loadCar() {
        if (DataManager.isLogged) {
            Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
                DataManager.token = token
                DataManager.getUser(completion: { (name, car) in
                    if (car.isBlank)
                    {
                        LoginViewController.shared?.skipbutton.sendActions(for: .touchUpInside)
                        return
                    }
                    
                    DataSource.userCar = car
                    DataSource.saveCar()
                    
                    DataSource.updateCarInfo {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateInitialViewController()
                        self.window?.rootViewController = vc
                    }
                    
                })
            })
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if error != nil {
            // ...
            LoginViewController.shared?.setWaiting(wait: false)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                // ...
                return
            }
            
            self.loadCar()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

