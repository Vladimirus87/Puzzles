//
//  PlayfieldViewController.swift
//  PhonePuzzle
//
//  Created by moisey on 29.01.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class PlayfieldViewController: UIViewController, PuzzlePartsCollectionDelegate, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var partsCollection: PuzzlePartsCollectionView!
    
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var movesValueLabel: UILabel!
    
    @IBOutlet weak var newGameButton: GreenButton!
    @IBOutlet weak var previewButon: GreenButton!
    
    var dragView: UIImageView?
    
    fileprivate var playfieldFlowController: PlayfieldFlowController!
    var playfieldViewModel: PlayfieldViewModel!
    
    func assignDependencies(playfieldFlowController: PlayfieldFlowController, playfieldViewModel: PlayfieldViewModel) {
        
        self.playfieldFlowController = playfieldFlowController
        self.playfieldViewModel = playfieldViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playfieldViewModel.fieldsCenters = gridView.getFieldsCenters()
    }

    private func setup() {
        
        movesLabel.textColor = UIColor.puzzleBlue
        movesValueLabel.textColor = UIColor.puzzleBlue
        movesValueLabel.text = "\(0)"
        newGameButton.text = String.localized(key: .playfield_new_game_button)
        newGameButton.fontSize = 15
        previewButon.text = String.localized(key: .playfield_preview_button)
        previewButon.fontSize = 15
        
        self.gridView.gridSize = sqrt(CGFloat(playfieldViewModel.puzzles.count))
        partsCollection.ownerController = self
        partsCollection.puzzlePartCollectionDelegate = self
        partsCollection.inputDataSource = playfieldViewModel.puzzles
//        playfieldViewModel.fieldsCenters = gridView.getFieldsCenters()//переместил в didAppear
    }
    
    func didRemovePuzzlePart(view: UIView) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        pan.delegate = self
                
        view.addGestureRecognizer(pan)
        view.isUserInteractionEnabled = true
        view.superview?.isUserInteractionEnabled = true
        
        movesValueLabel.text?.countUp()
        let viewAtFields = (gridView.subviews.filter{ $0.center == view.center })
        if viewAtFields.count == 2 {
            if let viewAtField = viewAtFields.first {
                guard let image = (viewAtField as? UIImageView)?.image else {return}
                partsCollection.inputDataSource.append(image)
                viewAtField.removeFromSuperview()
                partsCollection.reloadData()
            }
        }
    }
    
    
    func allPuzzlesDidSet() {

        if playfieldViewModel.isPuzzleCorrect(puzzleFields: gridView.subviews) {
            
            alert(title: String.localized(key: .playfield_puzzle_correct_title),
                  text: String(format: String.localized(key: .playfield_puzzle_correct_message), movesValueLabel.text!),
                  actions: [.NewGame],
                  actionHandler: { (action) in
                    
                    switch action {
                    case .NewGame:
                        self.playfieldFlowController.newGame()
                    default:
                        break
                    }
            })
        
        } else {
            alert(title: String.localized(key: .playfield_puzzle_incorrect_title),
                  text: String.localized(key: .playfield_puzzle_incorrect_message),
                  actions: [.NewGame, .Correct],
                  actionHandler: { (action) in
                
                    switch action {
                    case .NewGame:
                        self.playfieldFlowController.newGame()
                    case .Correct:
                        break
                    }
            })
        }
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
                
        switch sender.state {
            
        case .began:
            gridView.bringSubview(toFront: sender.view!)
            
        case .changed:
            sender.view?.center = sender.location(in: gridView)
            
        case .ended:
            
            movesValueLabel.text?.countUp()
            
            guard let senderView = sender.view else {return}
            
            if gridView.bounds.contains(sender.view!.center) {
                
                guard let newCenter = sender.view?.center.closestPoint(in: playfieldViewModel.fieldsCenters) else {return}

                if let viewAtField = (gridView.subviews.filter{ $0.center == newCenter }).first {
                    
                    guard let image = (viewAtField as? UIImageView)?.image else {return}
                    partsCollection.inputDataSource.append(image)
                    viewAtField.removeFromSuperview()
                    partsCollection.reloadData()
                }
                
                sender.view?.center = newCenter
            } else {                
                guard let image = (senderView as? UIImageView)?.image else {return}
                partsCollection.inputDataSource.append(image)
                senderView.removeFromSuperview()
                partsCollection.reloadData()
            }
            
        default:
            print("")
        }
    }
    
    @IBAction func newGameButtonAction(_ sender: Any) {
        playfieldFlowController.newGame()
    }
    
    @IBAction func previewButtonAction(_ sender: Any) {
        playfieldFlowController.showPreview(image: playfieldViewModel.resultImage)
    }
    
}
