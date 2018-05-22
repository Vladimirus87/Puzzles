//
//  PreviewFactory.swift
//  PhonePuzzle
//
//  Created by moisey on 02.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class PreviewFactory {
 
    static func present(image: UIImage, over viewController: UIViewController) {
        
        let previewController = UIStoryboard(name: "PlayfieldSB", bundle: nil).instantiateViewController(withIdentifier: "Preview") as! PreviewViewController
        previewController.modalPresentationStyle = .overCurrentContext
        let viewModel = PreviewViewModel(image: image)
        previewController.assignDependencies(previewViewModel: viewModel)
        
        viewController.present(previewController, animated: true, completion: nil)
    }
}
