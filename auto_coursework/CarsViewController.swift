//
//  CarsViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 04.05.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class CarsViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        //self.navigationController?.navigationBar.topItem?.title = "Мои автомобили"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.carStore.carsContainer.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as! TableViewCell
        
        let car = DataSource.carStore.carsContainer[indexPath.row]
        
        cell.textLabel?.text = car.name
        
        cell.setShadow()
        
        return cell
    }
    
}
