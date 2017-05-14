//
//  CustomTabBar.swift
//  auto_coursework
//
//  Created by Александр Пономарев on 20.04.17.
//  Copyright © 2017 Alexander Ponomarev. All rights reserved.
//

import UIKit

protocol CustomTabBarDataSource {
    func tabBarItemsInCustomTabBar(tabBarView: CustomTabBar)->[UITabBarItem]
}

protocol CustomTabBarDelegate {
    func didSelectViewController(tabBarView: CustomTabBar, atIndex index: Int )
}

class CustomTabBar: UIView {
    
    var inactiveColor: UIColor!
    var activeColor: UIColor!
    
    var initialTabBarItemIndex: Int!
    var selectedTabBarItemIndex: Int!
    
    // Instance of default tab bar controller for getting default tab bar items
    var dataSource: CustomTabBarDataSource!
    
    var tabBarItems: [UITabBarItem]!
    
    var customTabBarItems: [CustomTabBarItem]!
    var tabBarButtons: [UIButton]!
    
    var delegate: CustomTabBarDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set tab bar background color
        self.backgroundColor = UIColor.white
        
        // Set tab bar shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.06
        self.layer.shadowOffset = CGSize(width: 0, height: -4)
        self.layer.shadowRadius = 6.0
        self.clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        // Get tab bar items from default tab bar
        tabBarItems = dataSource.tabBarItemsInCustomTabBar(tabBarView: self)
        
        customTabBarItems = []
        tabBarButtons = []
        
        initialTabBarItemIndex = 0
        selectedTabBarItemIndex = initialTabBarItemIndex
        
        inactiveColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        activeColor = UIColor(red:0.56, green:0.60, blue:0.74, alpha:1.00)
        
        let containers = createTabBarItemContainers()
        createTabBarItems(containers: containers)
    }
    
    // Create container(size and position on tabBar view) for tabBarItem by given index
    func createTabBarItemContainer(index: Int) -> CGRect {
        let tabBarContainerWidth = self.frame.width / CGFloat(tabBarItems.count)
        let tabBarContainerRect = CGRect(x: tabBarContainerWidth * CGFloat(index), y: 0, width: tabBarContainerWidth, height: self.frame.height)
        
        return tabBarContainerRect
    }
    
    // Create array of containers using createTabBarItemContainer
    func createTabBarItemContainers() -> [CGRect] {
        var containerArray = [CGRect]()
        
        for index in 0..<tabBarItems.count {
            let tabBarContainer = createTabBarItemContainer(index: index)
            containerArray.append(tabBarContainer)
        }
        
        return containerArray
    }
    
    // Create custom tab bar items by connecting array of containers (argument) and default tab bar items (general variable)
    func createTabBarItems(containers: [CGRect]) {
        
        var index = 0
        for item in tabBarItems {
            
            let container = containers[index]
            
            let customTabBarItem = CustomTabBarItem(frame: container)
            customTabBarItem.setup(item: item)
            
            self.addSubview(customTabBarItem)
            customTabBarItems.append(customTabBarItem)
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: container.width, height: container.height))
            button.addTarget(self, action: #selector(self.barItemTapped(sender:)), for: UIControlEvents.touchUpInside)
            
            customTabBarItem.iconView.tintColor = inactiveColor
            
            customTabBarItem.addSubview(button)
            tabBarButtons.append(button)
            
            index += 1
        }
        
        self.customTabBarItems[initialTabBarItemIndex].iconView.tintColor = activeColor
    }
    
    // Action: change showing viewController index in customTabBarController
    func barItemTapped(sender: UIButton) {
        // Get index of tapped tab bar button
        let index = tabBarButtons.index(of: sender)!
        
        // Change tab bar items color to display changing showing viewController
        animateTabBarSelection(from: selectedTabBarItemIndex, to: index)
        selectedTabBarItemIndex = index
        
        // Call delegate func to change showing viewController index
        delegate.didSelectViewController(tabBarView: self, atIndex: index)
    }
    
    func animateTabBarSelection(from: Int, to: Int) {
        customTabBarItems[from].iconView.tintColor = inactiveColor
        customTabBarItems[to].iconView.tintColor = activeColor
    }
    
}
