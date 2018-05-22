//
//  UIView+blurEffect.swift
//  PhonePuzzle
//
//  Created by moisey on 19.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

extension UIView {
    
    func blurred(style: UIBlurEffectStyle, alpha: CGFloat, cornerRadius: CGFloat?, corners: UIRectCorner?)
    {
        self.backgroundColor = UIColor.clear
        
        let blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: style)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView.alpha = alpha
        
        if let _radius = cornerRadius, let _corners = corners
        {
            let path = UIBezierPath(roundedRect:blurEffectView.bounds,
                                    byRoundingCorners: _corners,
                                    cornerRadii: CGSize(width: _radius, height:  _radius))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            blurEffectView.layer.mask = maskLayer
        }
        
        blurEffectView.clipsToBounds = true
        self.clipsToBounds = true
        
        //if 'self' is a UIColectionView or UITableView the blurEffectView would cover the cells so it should change the view's 'backgroundView' instead
        
        if self.isKind(of: UICollectionView.self)
        {
            (self as! UICollectionView).backgroundView = blurEffectView
        }
        else if self.isKind(of: UITableView.self)
        {
            (self as! UITableView).backgroundView = blurEffectView
        }
        else
        {
            self.addSubview(blurEffectView)
            self.sendSubview(toBack: blurEffectView)
        }
    }
}
