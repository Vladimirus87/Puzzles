//
//  CameraServices.swift
//  PhonePuzzle
//
//  Created by moisey on 23.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

protocol CameraManagerDelegate {
    func photoChosen(photo: UIImage)
}

class CameraManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let imagePicker: UIImagePickerController! = UIImagePickerController()
    private var viewController: UIViewController!
    
    var delegate: CameraManagerDelegate? = nil
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        self.imagePicker.delegate = self
    }
    
    func takePhoto()
    {
        //check if the camera is available
        if (UIImagePickerController.isSourceTypeAvailable(.camera))
        {
            //check the rear camera
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil
            {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                
                if UIApplication.shared.statusBarOrientation == .portrait
                {
                    viewController.present(self.imagePicker, animated: true, completion: nil)
                }
                else
                {
                    viewController.present(imagePicker, animated: true, completion: nil)
                }
            }
            else
            {
                print("Application cannot access the camera.")
            }
        }
        else
        {
            print("Application cannot access the camera.")
        }
    }
    
    //browse phone photo gallery
    func browseDevicePhotoLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = false
            
            if UIApplication.shared.statusBarOrientation == .portrait
            {
                viewController.present(self.imagePicker, animated: true, completion: nil)
            }
            else
            {
                viewController.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    //when the user accepts the photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            delegate?.photoChosen(photo: image)
        }
        
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        viewController.dismiss(animated: true, completion: nil)
    }
}
