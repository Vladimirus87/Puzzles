//
//  PreviewViewController.swift
//  PhonePuzzle
//
//  Created by moisey on 28.01.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    fileprivate var previewViewModel: PreviewViewModel!
    
    func assignDependencies(previewViewModel: PreviewViewModel) {
        
        self.previewViewModel = previewViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    private func setup() {
        
        closeButton.setTitleColor(UIColor.lightGold, for: .normal)
        previewImageView.image = previewViewModel.image
        self.view.blurred(style: .dark, alpha: 0.7, cornerRadius: nil, corners: nil)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
