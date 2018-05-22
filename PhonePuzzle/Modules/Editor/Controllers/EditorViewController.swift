//
//  EditorViewController.swift
//  PhonePuzzle
//
//  Created by moisey on 23.01.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController, UIScrollViewDelegate, CounterDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var startButton: GreenButton!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    fileprivate var editorFlowController: EditorFlowController!
    fileprivate var editorViewModel: EditorViewModel!
    
    func assignDependencies(editorFlowController: EditorFlowController, editorViewModel: EditorViewModel) {
        
        self.editorFlowController = editorFlowController
        self.editorViewModel = editorViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        coverView.cutHole(in: gridView)
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    private func setup() {
        
        scrollView.delegate = self
        counterView.delegate = self
        startButton.text = String.localized(key: .editor_start_button)
        imageView.image = editorViewModel.photo
        closeButton.setTitleColor(UIColor.puzzleBlue, for: .normal)
        subtitleLabel.text = String.localized(key: .editor_subtitle)
        subtitleLabel.textColor = UIColor.puzzleBlue
    }
    
    private func setZoomScale() {
        
        self.view.layoutIfNeeded()
        
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        
        editorViewModel.getZoomScale(scrollViewSize: scrollViewSize, imageViewSize: imageViewSize)
        scrollView.minimumZoomScale = editorViewModel.minZoomScale
        scrollView.zoomScale = editorViewModel.minZoomScale
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //center the scroll view content
    func scrollViewDidZoom(_ scrollView: UIScrollView)
    {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    func counterValueDidChange(value: Int) {
        DispatchQueue.main.async(execute: {
            self.gridView.gridSize = CGFloat(value)
        })
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        editorFlowController.closeEditor()
    }
    
    @IBAction func startButtonAction(_ sender: GreenButton) {
        
        let (image, croppedImage) = EditorViewModel.getImage(from: scrollView, in: gridView.frame)
        
        guard let _image = image else {return}
        guard let _croppedImage = croppedImage else {return}
        
        editorFlowController.startPlayfield(from: UIImage(cgImage: _croppedImage,
                                                          scale: _image.scale,
                                                          orientation: _image.imageOrientation),
                                            into: Int(gridView.gridSize),
                                            proccessor: editorViewModel.getPuzzles)
    }
    
}
