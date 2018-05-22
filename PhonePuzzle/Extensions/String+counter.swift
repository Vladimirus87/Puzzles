//
//  String+counter.swift
//  PhonePuzzle
//
//  Created by moisey on 15.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import Foundation

extension String {
    
    mutating func countUp() {
        
        if let value = Int(self) {
         
            self = "\(value + 1)"
        }
    }
}
