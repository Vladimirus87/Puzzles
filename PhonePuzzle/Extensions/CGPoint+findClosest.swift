//
//  CGPoint+findClosest.swift
//  PhonePuzzle
//
//  Created by moisey on 12.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

extension CGPoint {
    
    func closestPoint(in array: [CGPoint]) -> CGPoint {
        
        var distances: [CGFloat] = []
        
        for point in array {
            
            distances.append(distance(self, point))
        }
        
        guard let minimum = distances.min() else {return array[0]}
        guard let index = distances.index(of: minimum) else {return array[0]}
        return array[index]
    }
    
    private func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
}
