//
//  PlayfieldFlowController.swift
//  PhonePuzzle
//
//  Created by moisey on 02.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class PlayfieldFlowController {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func newGame() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showPreview(image: UIImage) {
        PreviewFactory.present(image: image, over: navigationController)
    }
}
