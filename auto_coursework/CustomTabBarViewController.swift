//
//  ViewController.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 20.04.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController, CustomTabBarDataSource, CustomTabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.isHidden = true
        
        let customTabBar = CustomTabBar(frame: self.tabBar.frame)
        self.view.addSubview(customTabBar)
        
        customTabBar.dataSource = self
        customTabBar.delegate = self
        customTabBar.setup()
        
        self.selectedIndex = customTabBar.initialTabBarItemIndex
    }

    func tabBarItemsInCustomTabBar(tabBarView: CustomTabBar)->[UITabBarItem] {
        return self.tabBar.items!
    }
    
    func didSelectViewController(tabBarView: CustomTabBar, atIndex index: Int ) {
        self.selectedIndex = index
    }
    
    func shouldSelectViewController(tabBarView: CustomTabBar, viewControllerIndex: Int) -> Bool {
        if (viewControllerIndex == 1) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "add_info")
            present(vc!, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}

