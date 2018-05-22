//
//  UIView+cutHole.swift
//  PhonePuzzle
//
//  Created by moisey on 23.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

extension UIView {
    
    func cutHole(in view: UIView) {
        
        let maskView = UIView(frame: self.bounds)
        maskView.clipsToBounds = true;
        maskView.backgroundColor = UIColor.clear
        
        let outerbezierPath = UIBezierPath.init(rect: self.bounds)
        let holePath = UIBezierPath.init(rect: view.frame)
        outerbezierPath.append(holePath)
        outerbezierPath.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = UIColor.green.cgColor
        fillLayer.path = outerbezierPath.cgPath
        maskView.layer.addSublayer(fillLayer)
        
        self.mask = maskView
    }
}
