//
//  PuzzlePartCell.swift
//  PhonePuzzle
//
//  Created by moisey on 30.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//


import UIKit

class PuzzlePartCell: UICollectionViewCell {

    @IBOutlet weak var puzzlePartImageView: UIImageView!
    
    func config(photoPart: UIImageView) {
        //puzzlePartImageView.image = photoPart.image
        self.addSubview(photoPart)
    }
    
    override func prepareForReuse() {
//        puzzlePartImageView.image = UIImage()
//        puzzlePartImageView.alpha = 1
    }
}
