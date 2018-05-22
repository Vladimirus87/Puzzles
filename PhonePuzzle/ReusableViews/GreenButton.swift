//
//  GreenButton.swift
//  PhonePuzzle
//
//  Created by moisey on 28.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class GreenButton: UIButton {    
    
    var text = "" {
        didSet {
            self.setTitle(text, for: .normal)
        }
    }
    
    var fontSize: CGFloat = 25 {
        didSet {
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    

    func setup() {
        
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.puzzleGreen
        self.setTitle(text, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        self.setTitleColor(UIColor.lightGold, for: .normal)
    }
}
