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
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var lineChartView: LineChartView!
    
    @IBOutlet var mainView: UIView!
    
    var dispersion: Double!
    
    var expectedValue: Double!
    
    var userConsumption: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView = LineChartView()
        
        mainView.addSubview(lineChartView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dispersion = DataSource.userCar.index?.deviationConsumption ?? 1
        expectedValue = DataSource.userCar.index?.meanConsumption ?? 0
        userConsumption = DataSource.consumption ?? 0
        
        let f  = {
            var temp: String
            switch DataSource.userCar.status?.message ?? "" {
            case "OK":
                temp = "Все в порядке".uppercased()
            case "alert":
                temp = "Проведите тех. обслуживание".uppercased()
            case "warning":
                temp = "Возможно что-то не так".uppercased()
            default:
                temp = "Статус автомобиля".uppercased()
            }
            self.statusLabel.text = temp
        }
        
        f()
        DataSource.loadCarStatus(completion: f)
        
        let arrayOfX = generateArrayOfX(from: expectedValue - 3 * dispersion, to: expectedValue + 3 * dispersion + 0.1, step: 0.1)
        let arrayOfY = generateArrayOfY(ArrayOfX: arrayOfX, μ: expectedValue, σ: dispersion)
        
        setChart(xaxisValues: arrayOfX, yaxisValues: arrayOfY)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChartView.frame = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
    }
    
    func setChart(xaxisValues: [Double], yaxisValues: [Double]) {
        
        lineChartView.isUserInteractionEnabled = false
        
        // XAXIS
        let xaxis = lineChartView.xAxis
        xaxis.labelPosition = .bottom
        xaxis.drawAxisLineEnabled = false
        xaxis.drawGridLinesEnabled = false
        xaxis.labelTextColor = UIColor(red:0.56, green:0.60, blue:0.74, alpha:1.00)
        // font
        xaxis.labelFont = UIFont.systemFont(ofSize: 11, weight: UIFontWeightMedium)
        
        // YAXIS
        lineChartView.getAxis(YAxis.AxisDependency.right).enabled = false
        let yaxis = lineChartView.getAxis(YAxis.AxisDependency.left)
        yaxis.drawAxisLineEnabled = false
        yaxis.labelTextColor = UIColor(red:0.83, green:0.85, blue:0.90, alpha:1.00)
        yaxis.gridColor = UIColor(red:0.83, green:0.84, blue:0.90, alpha:1.00)
        yaxis.drawLabelsEnabled = false
        
        lineChartView.chartDescription?.text = ""
        
        lineChartView.legend.enabled = false
        
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<xaxisValues.count {
            let dataEntry = ChartDataEntry(x: xaxisValues[i], y: yaxisValues[i])
            dataEntries.append(dataEntry)
        }
        
        // Normal distribution
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "")
        lineChartDataSet.setColor(NSUIColor(red:0.56, green:0.60, blue:0.74, alpha:1.00))
        lineChartDataSet.lineWidth = 3.0
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.drawValuesEnabled = false
        
        // Normal point
        let normalPointEntry = ChartDataEntry(x: expectedValue, y: normalDistribution(μ: expectedValue, σ: dispersion, x: expectedValue))
        var normalPointEntries: [ChartDataEntry] = []
        normalPointEntries.append(normalPointEntry)
        let lineChartDataSetNormalPoint = LineChartDataSet(values: normalPointEntries, label: "")
        lineChartDataSetNormalPoint.circleRadius = 3.5
        lineChartDataSetNormalPoint.drawCircleHoleEnabled = false
        lineChartDataSetNormalPoint.drawValuesEnabled = false
        lineChartDataSetNormalPoint.setCircleColor(NSUIColor(red:0.56, green:0.60, blue:0.74, alpha:1.00))
        
        
        // User point
        let userPointEntry = ChartDataEntry(x: getUserPosition().x, y: getUserPosition().y)
        var userPointEntries: [ChartDataEntry] = []
        userPointEntries.append(userPointEntry)
        let lineChartDataSetOnePoint = LineChartDataSet(values: userPointEntries, label: "")
        lineChartDataSetOnePoint.circleRadius = 5.5
        lineChartDataSetOnePoint.circleHoleRadius = 2.8
        lineChartDataSetOnePoint.drawValuesEnabled = false
        lineChartDataSetOnePoint.setCircleColor(NSUIColor(red:0.56, green:0.60, blue:0.74, alpha:1.00))
        lineChartDataSetOnePoint.circleHoleColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00)
        
        var dataSets = [lineChartDataSet,lineChartDataSetNormalPoint]
        if userConsumption != 0 {
            dataSets.append(lineChartDataSetOnePoint)
        }
        
        let lineChartData = LineChartData(dataSets: dataSets)
        lineChartView.data = lineChartData
    }
    
    func standardNormalDistribution(x : Double) -> Double {
        return normalDistribution(μ: 0.0, σ: 1.0, x: x)
    }
    
    func ø(x:Double) -> Double {
        return standardNormalDistribution(x: x)
    }
    
    func normalDistribution(μ:Double, σ:Double, x:Double) -> Double {
        let a = exp( -1 * pow(x-μ, 2) / ( 2 * pow(σ,2) ) )
        let b = σ * sqrt( 2 * Double.pi )
        return a / b
    }
    
    func generateArrayOfY(ArrayOfX: [Double], μ:Double, σ:Double) -> [Double] {
        var generatingArray = [Double]()
        for i in ArrayOfX {
            generatingArray.append(normalDistribution(μ: μ, σ: σ, x: i))
        }
        return generatingArray
    }
    
    func generateArrayOfX(from: Double, to: Double, step: Double)  -> [Double] {
        var i: Double = from
        var generatingArray = [Double]()
        while(i < to) {
            generatingArray.append(i)
            i += step
        }
        return generatingArray
    }
    
    func getUserPosition() -> (x: Double, y: Double) {
        let temp = normalDistribution(μ: expectedValue, σ: dispersion, x: userConsumption)
        return (userConsumption, temp)
    }
    
}
