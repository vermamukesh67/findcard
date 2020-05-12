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
    var isResetData = false
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: "HerokuGameCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HerokuGameCell")
        self.collectionView.backgroundColor = UIColor.black
    }
    @IBAction func btnRestartTapped(_ sender: Any) {
        viewModel.resetGameData()
        isResetData = true
        self.collectionView.reloadData()
        isResetData = false
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
         cell.updateCell(card: viewModel.getData(index: indexPath.row), disPlayText: viewModel.cardBackText, isAnimate: isResetData)
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? HerokuGameCell else {
            return
        }
        viewModel.updateCardStatus(index: indexPath.row)
        cell.updateCell(card: viewModel.getData(index: indexPath.row), disPlayText: viewModel.cardBackText, isAnimate: true)
        viewModel.increastTotalStep()
        self.lblTotalSteps.text = "STEPS: \(viewModel.totalStpes)"
    }
}
