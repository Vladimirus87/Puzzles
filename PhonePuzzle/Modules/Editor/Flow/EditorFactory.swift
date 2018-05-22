//
//  EditorFactory.swift
//  PhonePuzzle
//
//  Created by moisey on 23.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class EditorFactory {
    
    static func pushIn(navigationController: UINavigationController, photo: UIImage) {
    
        let editorController = UIStoryboard(name: "EditorSB", bundle: nil).instantiateInitialViewController() as! EditorViewController
        let editorFlowController = EditorFlowController(navigationController: navigationController)
        let viewModel = EditorViewModel(photo: photo)
        editorController.assignDependencies(editorFlowController: editorFlowController, editorViewModel: viewModel)

        navigationController.pushViewController(editorController, animated: true)
    }
}
