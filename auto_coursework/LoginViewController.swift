//
//  LoginViewController.swift
//  auto_coursework
//
//  Created by Matvey Kravtsov on 01/10/2017.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signinbutton: GIDSignInButton!
    @IBOutlet public weak var skipbutton: UIButton!
    @IBOutlet weak var loadingLabel: UILabel!
    
    public static var shared : LoginViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginViewController.shared = self
        setWaiting(wait: false)
        
        GIDSignIn.sharedInstance().uiDelegate = self
       // GIDSignIn.sharedInstance().signIn()
    }
    
    public func setWaiting(wait: Bool) {
        loadingLabel.isHidden = !wait
        signinbutton.isHidden = wait
        skipbutton.isHidden = wait
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        setWaiting(wait: true)
    }
 
    


}
