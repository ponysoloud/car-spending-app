//
//  StatisticsOutgoingPanelViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 05.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class StatisticsOutgoingPanelViewController: UIViewController {
    @IBOutlet weak var carNameLabel: UILabel!
    
    @IBOutlet weak var carDetailsLabel: UILabel!
    
    @IBOutlet weak var statisticsView: UIView!
    
    override func viewDidLoad() {
        let viewLayer = view.layer
        viewLayer.cornerRadius = 8
        
        viewLayer.shadowColor = UIColor.black.cgColor
        viewLayer.shadowOpacity = 0.05
        viewLayer.shadowOffset = CGSize(width: 0, height: 0)
        viewLayer.shadowRadius = 9.0
        view.clipsToBounds = false
        
        let topShadow = EdgeShadowLayer(forView: statisticsView, edge: .Top)
        let bottomShadow = EdgeShadowLayer(forView: statisticsView, edge: .Bottom)
        statisticsView.layer.addSublayer(topShadow)
        statisticsView.layer.addSublayer(bottomShadow)
        
        carNameLabel.text = DataSource.getCurrentCar().name
    }
    
}
