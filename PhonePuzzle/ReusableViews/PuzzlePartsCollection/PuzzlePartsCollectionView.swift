//
//  PuzzlePartsCollectionView.swift
//  PhonePuzzle
//
//  Created by moisey on 30.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

/*
 
 let puzzleMaker = PuzzleMaker(image: UIImage(named: "image")!, numRows: ViewController.numRows, numColumns: ViewController.numColumns)
 puzzleMaker.generatePuzzles { (throwableClosure) in
 do {
 let puzzleElements = try throwableClosure()
 for row in 0 ..< ViewController.numRows {
 for column in 0 ..< ViewController.numColumns {
 let puzzleElement = puzzleElements[row][column]
 let position = puzzleElement.position
 let image = puzzleElement.image
 let imgView = UIImageView(frame: CGRect(x: position.x, y: position.y, width: image.size.width, height: image.size.height))
 print(position.x)
 imgView.image = image
 self.img.addSubview(imgView)
 }
 }
 
 } catch let error {
 debugPrint(error)
 }
 }
 
 */





import UIKit
import PuzzleMaker


protocol PuzzlePartsCollectionDelegate {
    func didRemovePuzzlePart(view: UIView)
    func allPuzzlesDidSet()
}

class PuzzlePartsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var inputDataSource: [UIImage] = []
    var ownerController: PlayfieldViewController!
    var puzzlePartCollectionDelegate: PuzzlePartsCollectionDelegate? = nil
    
    var pazz = [UIImageView]()
    
    
    func changeSize(_ size: CGSize) ->  CGSize {
        if size.height == size.width {
            return CGSize(width: 126, height: 125)
        } else {
            return size
        }
    }
    
    static let numRows = 4
    static let numColumns = 4
    var counter = 0
    override func awakeFromNib() {
        delegate = self
        dataSource = self
        
        //let _countRowColumns = 2
        
        let puzzleMaker = PuzzleMaker(image: UIImage(named: "image")!, numRows: PuzzlePartsCollectionView.numRows, numColumns: PuzzlePartsCollectionView.numColumns)
        
        // 1) проблема заключаеться в том что пазлы уменьшаються в фреймворке, для коректного отбражения. Мне же нужно, чтоб все было в константной величине в коллекшине, а когда уже перетащил картинку в поле - эта формула годиться
        /// можно решить задачу путем коректирование размера, когда создаем imageView(image.size.width и image.size.height)
        // 2) трабла отображения ячеек, когда их переопределяет
        /// может пересмотреть логику хранения UIImageView
        
        puzzleMaker.generatePuzzles { (throwableClosure) in
            do {
                let puzzleElements = try throwableClosure()
                for row in 0 ..< PuzzlePartsCollectionView.numRows {
                    for column in 0 ..< PuzzlePartsCollectionView.numColumns {
                        let puzzleElement = puzzleElements[row][column]
                        let position = puzzleElement.position
                        let image = puzzleElement.image
                        
                       // Поправка на выпуклость пазла
                        func correctPazzleFrame() -> CGPoint {
                            let y = puzzleElement.puzzleUnit.topSegment.outerHeight > 0 ? 0 : 20.8
                            let x = puzzleElement.puzzleUnit.leftSegment.outerHeight > 0 ? 0 : 20.8
                            
                            return CGPoint(x: x, y: y)
                        }
                   
                        // puzzleElement.puzzleUnit.topSegment.outerHeight - если есть выступ сверху
                        
                        let imgView = UIImageView(frame: CGRect(x: correctPazzleFrame().x, y: correctPazzleFrame().y, width: image.size.width, height: image.size.height))
                        imgView.image = image
                        imgView.contentMode = .scaleAspectFit
                        imgView.isUserInteractionEnabled = true
                        self.pazz.append(imgView)
                        self.counter += 1
                        print(self.counter)
                    }
                }
                self.reloadData()
               
            } catch let error {
                debugPrint(error)
            }
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pazz.count//inputDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //imageSize + выступ от пазла
        return CGSize(width: 104.3, height: 104.3)
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "puzzlePartCell", for: indexPath) as! PuzzlePartCell
        //cell.puzzlePartImageView = pazz[indexPath.row]
        cell.config(photoPart: pazz[indexPath.row])//inputDataSource[indexPath.row])
        setupGestures(cell: cell)
        return cell
    }
    
    
    private func setupGestures(cell: PuzzlePartCell) {
        
        //long press
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        longPress.minimumPressDuration = 0.05

        cell.subviews.last?.addGestureRecognizer(longPress)//puzzlePartImageView
        cell.subviews.last?.isUserInteractionEnabled = true //puzzlePartImageView
    }

    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        
        if let cellView = sender.view {
            
            switch sender.state {
            case .began:
                let cellImgView = cellView as? UIImageView
                cellView.alpha = 0
                let newImageView = UIImageView(image: cellImgView?.image)
                newImageView.frame.size = CGSize(width: ownerController.gridView.gridWidth,
                                                 height: ownerController.gridView.gridHeight)
                newImageView.center = sender.location(in: ownerController.view)

                ownerController.dragView = newImageView
                ownerController.view.addSubview(ownerController.dragView!)

            case .changed:
                //перетаскивание вью по всему контроллеру
                ownerController.dragView?.center = sender.location(in: ownerController.view)
                
            case .ended:
                guard ownerController.dragView != nil else {return}
                
                // если перетаскуемое вью отпущено в зоне гридФрейма
                if ownerController.dragView!.frame.intersects(ownerController.gridView.frame) {

                    if let theDragView = ownerController.dragView {
                        
                        let newView = UIImageView()
                        newView.image = theDragView.image
                        
                        //calculate the center of the dragged view
                        var draggedCenter = theDragView.center
                        //порправка на гридВью
                        draggedCenter.x -=  ownerController.gridView.frame.origin.x
                        
                        draggedCenter.y -=  ownerController.gridView.frame.origin.y
                        
                        
                            //get the closest field in the grid view corresponding to the dragged view
                        var newCenter = draggedCenter.closestPoint(in: ownerController.playfieldViewModel.fieldsCenters)
                        
                        newCenter.x -=  ownerController.gridView.gridWidth/2
                        newCenter.y -=  ownerController.gridView.gridHeight/2
                        
                        newView.center = newCenter
                        
                        newView.frame.size = CGSize(width: ownerController.gridView.gridWidth,
                                                    height: ownerController.gridView.gridHeight)
                        ownerController.gridView.addSubview(newView)
                    }
                    
                    ownerController.dragView?.removeFromSuperview()
                    ownerController.dragView = nil

                    if let img = (cellView as! UIImageView).image, let index = self.inputDataSource.index(of: img) {
                        
                        ownerController.partsCollection.inputDataSource.remove(at: index)
                        ownerController.partsCollection.deleteItems(at: [IndexPath(item: index, section: 0)])
                        
                        if let lastSubview = ownerController.gridView.subviews.last {
                            puzzlePartCollectionDelegate?.didRemovePuzzlePart(view: lastSubview)
                        }
                    }
                    
                } else {
                    UIView.animate(withDuration: 1, animations: {
                        cellView.alpha = 1
                        self.ownerController.dragView?.removeFromSuperview()
                        self.ownerController.dragView = nil
                    })
                }
                
                if inputDataSource.count == 0 {
                    puzzlePartCollectionDelegate?.allPuzzlesDidSet()
                }
                
            default:
                print("Any other action?")
            }
        }
    }
}
