//
//  PlayfieldViewModel.swift
//  PhonePuzzle
//
//  Created by moisey on 29.01.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class PlayfieldViewModel {
    
    var resultImage: UIImage
    var puzzleDictionary: [Int : UIImage]
    var puzzles: [UIImage]
    var fieldsCenters: [CGPoint] = []
    
    init(resultImage: UIImage, puzzles: [Int : UIImage]) {
        self.resultImage = resultImage
        self.puzzleDictionary = puzzles
        self.puzzles = puzzles.values.map{$0}
    }
    
    private func indexOfPuzzle(with image: UIImage) -> Int? {
        
        guard let key = (puzzleDictionary as NSDictionary).allKeys(for: image).first else {return nil}
        return key as? Int
    }
    
    func isPuzzleCorrect(puzzleFields: [UIView]) -> Bool {
        
        for puzzleFieldView in puzzleFields {
          
            guard let image = (puzzleFieldView as? UIImageView)?.image else {return false}
            guard let fieldIndex = indexOfPuzzle(with: image) else {return false}
            guard let fieldCenterIndex = fieldsCenters.index(of: puzzleFieldView.center) else {return false}
            
            if fieldCenterIndex != fieldIndex {
                return false
            }
        }
        
        return true
    }
}
