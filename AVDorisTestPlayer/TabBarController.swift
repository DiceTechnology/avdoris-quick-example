//
//  TabBarController.swift
//  dice-shield-ios-example
//
//  Created by mac on 07.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        let firstViewController = DemoPlaybackViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Demo videos", image: UIImage(systemName: "play.rectangle"), tag: 0)
        
        let secondViewController = DicePlaybackViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Dice videos", image: UIImage(systemName: "video"), tag: 1)
        
        let thirdViewController = DownloadsViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Dice downloads", image: UIImage(systemName: "square.and.arrow.down"), tag: 2)
        
        let tabBarList = [firstViewController, secondViewController, thirdViewController]
        
        viewControllers = tabBarList
    }
}
