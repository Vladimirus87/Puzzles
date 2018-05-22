//
//  EditorViewModel.swift
//  PhonePuzzle
//
//  Created by moisey on 29.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class EditorViewModel {
    
    var photo: UIImage
    var minZoomScale: CGFloat = 0
    
    init(photo: UIImage) {
        self.photo = photo
    }
    
    
    func getZoomScale(scrollViewSize: CGSize, imageViewSize: CGSize) {
        
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        minZoomScale = min(widthScale, heightScale)
    }
    
    
    let getPuzzles: (UIImage, Int) -> ([Int : UIImage]) = { (photo, howMany) in
        let width: CGFloat
        let height: CGFloat
        
        switch photo.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            width = photo.size.height
            height = photo.size.width
        default:
            width = photo.size.width
            height = photo.size.height
        }
        
        let tileWidth = Int(width / CGFloat(howMany))
        let tileHeight = Int(height / CGFloat(howMany))
        
        let scale = Int(photo.scale)
        var puzzles = [Int : UIImage]()
        
        let cgImage = photo.cgImage!
        
        var adjustedHeight = tileHeight
        
        var y = 0
        for row in 0 ..< howMany {
            if row == (howMany - 1) {
                adjustedHeight = Int(height) - y
            }
            var adjustedWidth = tileWidth
            var x = 0
            for column in 0 ..< howMany {
                if column == (howMany - 1) {
                    adjustedWidth = Int(width) - x
                }
                let origin = CGPoint(x: x * scale, y: y * scale)
                let size = CGSize(width: adjustedWidth * scale, height: adjustedHeight * scale)
                let tileCgImage = cgImage.cropping(to: CGRect(origin: origin, size: size))!
                let image = UIImage(cgImage: tileCgImage, scale: photo.scale, orientation: photo.imageOrientation)
                
                puzzles[puzzles.count] = image
                
                x += tileWidth
            }
            y += tileHeight
        }
        return puzzles
    }
    
    
    static func getImage(from contextView: UIView, in cropFrame: CGRect) -> (UIImage?, CGImage?) {
        
        UIGraphicsBeginImageContext(CGSize(width: contextView.frame.size.width,
                                           height: contextView.frame.size.height))
        contextView.drawHierarchy(in: CGRect(x: contextView.frame.origin.x,
                                            y: contextView.frame.origin.y,
                                            width: contextView.frame.size.width,
                                            height: contextView.frame.size.height),
                                 afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return (nil, nil)}
        UIGraphicsEndImageContext()
        
        guard let croppedImage = image.cgImage?.cropping(to: cropFrame) else {return (image, nil)}
        return (image, croppedImage)
    }
}
