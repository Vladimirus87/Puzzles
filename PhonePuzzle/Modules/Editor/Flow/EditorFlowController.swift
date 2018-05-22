//
//  EditorFlowController.swift
//  PhonePuzzle
//
//  Created by moisey on 23.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class EditorFlowController {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func closeEditor() {
        self.navigationController.popViewController(animated: true)
    }
    
    func startPlayfield(from: UIImage, into: Int, proccessor: (UIImage, Int) -> ([Int : UIImage])) {
    
        PlayfieldFactory.pushIn(navigationController: navigationController,
                                resultImage: from,
                                puzzles: proccessor(from, into))
    }
}
