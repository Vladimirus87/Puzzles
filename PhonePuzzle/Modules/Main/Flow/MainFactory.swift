//
//  MainFactory.swift
//  PhonePuzzle
//
//  Created by moisey on 22.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class MainFactory {
    
    static func showIn(window: UIWindow) {
        
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        navigationController.navigationBar.backgroundColor = UIColor.lightGold
        navigationController.navigationBar.tintColor = UIColor.puzzleBlue
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.puzzleBlue]
        
        let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController
        let mainFlowController = MainFlowController(navigationController: navigationController)
        
        mainController.assignDependencies(mainFlowController: mainFlowController)
        
        navigationController.setViewControllers([mainController], animated: false)
        window.rootViewController = navigationController
    }
}
