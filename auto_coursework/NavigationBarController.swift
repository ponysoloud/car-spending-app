//
//  NavigationBarController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 04.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class NavigationBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar shadow
        let navView = self.navigationBar
        
        navView.layer.shadowColor = UIColor.black.cgColor
        navView.layer.shadowOpacity = 0.06
        navView.layer.shadowOffset = CGSize(width: 0, height: 4)
        navView.layer.shadowRadius = 6.0
        navView.clipsToBounds = false
        
        
        // Set statusBar color
        let statusBar = UIApplication.shared.statusBarFrame
        
        let plateView = UIView(frame: statusBar)
        plateView.backgroundColor = UIColor.white
        
        self.view.addSubview(plateView)
    }
    
}
