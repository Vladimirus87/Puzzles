//
//  MainViewController.swift
//  PhonePuzzle
//
//  Created by moisey on 22.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, GoldButtonDelegate, CameraManagerDelegate {

    
    @IBOutlet weak var logoTitleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var photoButton: GoldButton!
    @IBOutlet weak var browseButton: GoldButton!
    
    fileprivate var cameraManager: CameraManager!
    fileprivate var mainFlowController: MainFlowController!
    
    func assignDependencies(mainFlowController: MainFlowController) {
        
        self.mainFlowController = mainFlowController
        self.cameraManager = CameraManager(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoButton.delagate = self
        browseButton.delagate = self
        cameraManager.delegate = self
        
        logoTitleLabel.textColor = UIColor.puzzleBlue
        subtitleLabel.textColor = UIColor.puzzleBlue
        
        photoButton.style = .camera
        browseButton.style = .library
        
        mainFlowController.showEditor(with: UIImage(named: "image")!)
    }

    func goldButtonDidTapped(style: GoldButton.Style) {
        switch style {
        case .camera:
            cameraManager.takePhoto()
        case .library:
            cameraManager.browseDevicePhotoLibrary()
        }
    }
    
    func photoChosen(photo: UIImage) {
        mainFlowController.showEditor(with: photo)
    }
}
