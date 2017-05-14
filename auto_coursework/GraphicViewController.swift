//
//  GraphicViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 12.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit
import Charts

class GraphicViewController: UIViewController {
    
    var lineChartView: LineChartView!
    
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView = LineChartView()
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(dataPoints: months, values: unitsSold)
        
        mainView.addSubview(lineChartView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChartView.frame = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        lineChartView.isUserInteractionEnabled = false
        
        // XAXIS
        let xaxis = lineChartView.xAxis
        xaxis.labelPosition = .bottom
        xaxis.drawAxisLineEnabled = false
        xaxis.drawGridLinesEnabled = false
        xaxis.labelTextColor = UIColor(red:0.56, green:0.60, blue:0.74, alpha:1.00)
        // font
        xaxis.labelFont = UIFont.systemFont(ofSize: 11, weight: UIFontWeightThin)
        
        // YAXIS
        lineChartView.getAxis(YAxis.AxisDependency.right).enabled = false
        let yaxis = lineChartView.getAxis(YAxis.AxisDependency.left)
        yaxis.drawAxisLineEnabled = false
        yaxis.labelTextColor = UIColor(red:0.83, green:0.85, blue:0.90, alpha:1.00)
        yaxis.gridColor = UIColor(red:0.83, green:0.84, blue:0.90, alpha:1.00)
        
        lineChartView.chartDescription?.text = ""
        
        lineChartView.legend.enabled = false
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
    }
    
    
}
