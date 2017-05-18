//
//  CarStatsViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 17.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class CarStatsViewController: UIViewController {
    @IBOutlet weak var carImageView: UIImageView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsetsMake(-statusBarHeight, 0, 0, 0)
        scrollView.contentInset = insets
        
        carImageView.downloadedFrom(link: DataSource.userCar.image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        heightConstraint.constant = CGFloat(700 + 60 * DataSource.userCar.measurements.count)
    }
    
}
