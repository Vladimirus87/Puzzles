//
//  MainFlowController.swift
//  PhonePuzzle
//
//  Created by moisey on 22.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class MainFlowController {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showEditor(with photo: UIImage) {
        EditorFactory.pushIn(navigationController: navigationController, photo: photo)
    }
}
