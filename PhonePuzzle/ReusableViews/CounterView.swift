//
//  CounterView.swift
//  PhonePuzzle
//
//  Created by moisey on 28.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

protocol CounterDelegate {
    func counterValueDidChange(value: Int)
}

class CounterView: UIView {

    @IBOutlet weak var minusView: UIView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusView: UIView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet var contentView: UIView!
    
    var delegate: CounterDelegate? = nil
    
    private var counterValue: Int = 3 {
        didSet {
            counterLabel.text = "\(counterValue)"
        }
    }

    @IBAction func minusButtonAction(_ sender: UIButton) {
        if counterValue > 2 {
            counterValue -= 1
            delegate?.counterValueDidChange(value: counterValue)
        }
    }
    @IBAction func plusButtonAction(_ sender: UIButton) {
        if counterValue < 10 {
            counterValue += 1
            delegate?.counterValueDidChange(value: counterValue)
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
        
        loadViewFromNib()
        
        self.backgroundColor = UIColor.clear
        
        minusView.layer.cornerRadius = 10
        plusView.layer.cornerRadius = 10
        minusView.backgroundColor = UIColor.puzzleBlue
        plusView.backgroundColor = UIColor.puzzleBlue
        
        minusButton.setTitleColor(UIColor.lightGold, for: .normal)
        plusButton.setTitleColor(UIColor.lightGold, for: .normal)
        
        counterLabel.textColor = UIColor.puzzleBlue
    }
    
    func loadViewFromNib() {
        Bundle.main.loadNibNamed("CounterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
