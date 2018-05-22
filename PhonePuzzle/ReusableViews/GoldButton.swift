//
//  GoldButton.swift
//  PhonePuzzle
//
//  Created by moisey on 22.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

protocol GoldButtonDelegate {
    func goldButtonDidTapped(style: GoldButton.Style)
}

class GoldButton: UIButton {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    private let edgeSpace: CGFloat = 20
    
    var delagate: GoldButtonDelegate? = nil
    
    enum Style {
        case camera
        case library
    }
    
    var style: Style = .camera {
        didSet {
            customize(style: style)
        }
    }
    
    private func customize(style: Style) {
        switch style {
        case .camera:
            iconImageView.image = UIImage(named: "photoIcon")?.withRenderingMode(.alwaysTemplate)
            label.text = String.localized(key: .camera)
        case .library:
            iconImageView.image = UIImage(named: "browseIcon")?.withRenderingMode(.alwaysTemplate)
            label.text = String.localized(key: .library)
        }
        
        iconImageView.tintColor = UIColor.darkGray
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
        
        self.setTitle("", for: .normal)
        self.setTitle("", for: .disabled)
        self.setTitle("", for: .highlighted)
        
        iconImageView.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
    }
    
    func loadViewFromNib() {
        Bundle.main.loadNibNamed("GoldButton", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.isUserInteractionEnabled = false
        contentView.backgroundColor = UIColor.lightGold
        contentView.layer.cornerRadius = 10
    }

    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.width += 2 * edgeSpace
        return intrinsicSuperViewContentSize
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentView.backgroundColor = UIColor.darkGray
        iconImageView.tintColor = UIColor.lightGold
        label.textColor = UIColor.lightGold
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentView.backgroundColor = UIColor.lightGold
        iconImageView.tintColor = UIColor.darkGray
        label.textColor = UIColor.darkGray
        
        self.delagate?.goldButtonDidTapped(style: self.style)
    }
}
