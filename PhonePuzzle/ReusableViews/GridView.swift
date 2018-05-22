//
//  GridView.swift
//  PhonePuzzle
//
//  Created by moisey on 23.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class GridView: UIView
{
    private var path = UIBezierPath()
    private let lineWidth: CGFloat = 2
    var gridSize: CGFloat = 3 {
        didSet {
            drawGrid()
        }
    }

    var gridWidth: CGFloat = 0
    var gridHeight: CGFloat = 0
    
    fileprivate func drawGrid() {
        
            //clear the previous sublayer
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        }
        
        gridWidth = bounds.width/CGFloat(gridSize)
        gridHeight = bounds.height/CGFloat(gridSize)
        
        let gridLayer = CAShapeLayer()  //new layer
        
        path = UIBezierPath()
        path.lineWidth = lineWidth
        
        //draw columns
        for index in 1...Int(gridSize) - 1 {
            
            let start = CGPoint(x: CGFloat(index) * gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(index) * gridWidth, y: bounds.height)
            path.move(to: start)
            path.addLine(to: end)
        }
        
        //draw rows
        for index in 1...Int(gridSize) - 1 {
            
            let start = CGPoint(x: 0, y: CGFloat(index) * gridHeight)
            let end = CGPoint(x: bounds.width, y: CGFloat(index) * gridHeight)
            path.move(to: start)
            path.addLine(to: end)
        }
        
        //Close the path.
        path.close()
        
        self.layer.borderColor = UIColor.lightGold.cgColor
        self.layer.borderWidth = lineWidth
        
        self.layer.addSublayer(gridLayer)   //add the gridLayer as a sublayer to the self layer
        self.setNeedsDisplay()  //redraw layer
    }
    
    override func draw(_ rect: CGRect)
    {
        drawGrid()
        
        // Specify a border (stroke) color.
        UIColor.lightGold.setStroke()
        path.stroke()
    }
    
    func getFieldsCenters() -> [CGPoint] {
        
        var centers: [CGPoint] = []
        
        let fromX = gridWidth/CGFloat(2)
        let toX = gridSize * gridWidth
        
        let fromY = gridHeight/CGFloat(2)
        let toY = gridSize * gridHeight
        
        for centerY in stride(from: fromY, to: toY, by: gridHeight) {
            
            for centerX in stride(from: fromX, to: toX, by: gridWidth) {
                
                centers.append(CGPoint(x: centerX, y: centerY))
            }
        }

        return centers
    }
}
