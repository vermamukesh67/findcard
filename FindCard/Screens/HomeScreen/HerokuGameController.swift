//
//  ViewController.swift
//  FindCard
//
//  Created by Chandresh Maurya on 12/05/20.
//  Copyright © 2020 com.mukesh. All rights reserved.
//

import UIKit

class HerokuGameController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var lblTotalSteps: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = HerokuGameViewModel(totalPair: 6)
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: "HerokuGameCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HerokuGameCell")
        self.collectionView.backgroundColor = UIColor.black
    }
    @IBAction func btnRestartTapped(_ sender: Any) {
       resetGame()
    }
    func resetGame() {
        viewModel.resetGameData()
        viewModel.isPlaying = true
        var indexpaths: [IndexPath] = []
        for (index, _) in viewModel.allCardData.enumerated() {
            indexpaths.append(IndexPath.init(row: index, section: 0))
        }
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: indexpaths)
            self.collectionView.insertItems(at: indexpaths)
        }) { (isDone) in
            self.viewModel.isPlaying = false
        }
        self.lblTotalSteps.text = "STEPS: \(viewModel.totalStpes)"
    }
}
extension HerokuGameController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTotalNumberOfCardData()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HerokuGameCell", for: indexPath) as? HerokuGameCell else {
            return UICollectionViewCell()
        }
         cell.updateCell(card: viewModel.getData(index: indexPath.row), disPlayText: viewModel.cardBackText, isAnimate: viewModel.isPlaying)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Int = (Int(collectionView.frame.size.width) - 40) / viewModel.numberOfCellPerRow
        return CGSize.init(width:  width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.getStatus(index: indexPath.row) != .back || viewModel.isPlaying {
           return
        }
        guard let cell = collectionView.cellForItem(at: indexPath) as? HerokuGameCell else {
            return
        }
        viewModel.isPlaying = true
        updateCard(indexPath, collectionView, cell)
        viewModel.increastTotalStep()
        self.lblTotalSteps.text = "STEPS: \(viewModel.totalStpes)"
    }
    fileprivate func updateCard(_ indexPath: IndexPath, _ collectionView: UICollectionView, _ cell: HerokuGameCell) {
        viewModel.updateCardStatus(index: indexPath.row)
        cell.updateCell(card: viewModel.getData(index: indexPath.row), disPlayText: viewModel.cardBackText, isAnimate: true, completionHandler: {
            self.viewModel.isPlaying = false
            self.checkForPairMatching(indexPath: indexPath)
        })
    }
    func checkForPairMatching(indexPath: IndexPath) {
        viewModel.addDataIntoOpenCard(card: viewModel.getData(index: indexPath.row))
        if viewModel.isPairMatched() {
            viewModel.lastSelectedIndex = nil
            self.checkIfGameFinished()
        } else {
            if let lastSelectedIndex = viewModel.lastSelectedIndex {
                viewModel.lastSelectedIndex = nil
                let lastIndexPath = IndexPath.init(row: lastSelectedIndex, section: 0)
                viewModel.setStaus(index: lastSelectedIndex, status: .back)
                viewModel.setStaus(index: indexPath.row, status: .back)
                guard let prevSelectedcell = collectionView.cellForItem(at: lastIndexPath) as? HerokuGameCell else {
                    return
                }
                guard let currentCell = collectionView.cellForItem(at: indexPath) as? HerokuGameCell else {
                    return
                }
                prevSelectedcell.updateCell(card: viewModel.getData(index: lastSelectedIndex), disPlayText: viewModel.cardBackText, isAnimate: true)
                currentCell.updateCell(card: viewModel.getData(index: indexPath.row), disPlayText: viewModel.cardBackText, isAnimate: true)
                
            } else {
                viewModel.lastSelectedIndex = indexPath.row
                
            }
        }
    }
    func checkIfGameFinished() {
        if viewModel.isGameFinished() {
            let actionSheet = UIAlertController(title: "Congratulations!", message: "You won this game by \(viewModel.totalStpes) steps", preferredStyle: .alert)
            actionSheet.addAction(UIAlertAction(title: "Try another round", style: .default, handler: { (_)in
                self.resetGame()
            }))
            self.present(actionSheet, animated: true, completion: {
            })
        }
        
    }
}
