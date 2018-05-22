//
//  UIImage+compare.swift
//  PhonePuzzle
//
//  Created by moisey on 18.03.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

extension UIImage {
    
    func isEqual(to image: UIImage) -> Bool {
        
        if let selfData = UIImagePNGRepresentation(self), let imageData = UIImagePNGRepresentation(image) {
            return selfData == imageData
        }
        else {
            return false
        }
    }
}
