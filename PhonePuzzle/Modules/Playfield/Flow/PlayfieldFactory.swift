//
//  PlayfieldFactory.swift
//  PhonePuzzle
//
//  Created by moisey on 02.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class PlayfieldFactory {
    
    static func pushIn(navigationController: UINavigationController, resultImage: UIImage, puzzles: [Int : UIImage]) {
                
        let playfieldController = UIStoryboard(name: "PlayfieldSB", bundle: nil).instantiateInitialViewController() as! PlayfieldViewController
        let playfieldFlowController = PlayfieldFlowController(navigationController: navigationController)
        let viewModel = PlayfieldViewModel(resultImage: resultImage, puzzles: puzzles)
        playfieldController.assignDependencies(playfieldFlowController: playfieldFlowController, playfieldViewModel: viewModel)
        
        navigationController.pushViewController(playfieldController, animated: true)
    }
}
