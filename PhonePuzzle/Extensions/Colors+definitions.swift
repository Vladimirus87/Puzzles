//
//  Colors+definitions.swift
//  PhonePuzzle
//
//  Created by moisey on 22.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red")
        assert(green >= 0 && green <= 255, "Invalid green")
        assert(blue >= 0 && blue <= 255, "Invalid blue")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    static let lightGold = UIColor(hex: 0xF3E9D2)
    static let puzzleGreen = UIColor(hex: 0x1A936F)
    static let puzzleBlue = UIColor(hex: 0x114B5F)
}
