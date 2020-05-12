//
//  ViewController.swift
//  FindCard
//
//  Created by Chandresh Maurya on 12/05/20.
//  Copyright © 2020 com.mukesh. All rights reserved.
//

import UIKit

class HerokuGameController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = HerokuGameViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: "HerokuGameCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HerokuGameCell")
        self.collectionView.backgroundColor = UIColor.black
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTotalNumberOfCardData()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HerokuGameCell", for: indexPath) as? HerokuGameCell else {
            return UICollectionViewCell()
        }
        cell.updateCell(text: viewModel.getData(index: indexPath.row))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Int = (Int(collectionView.frame.size.width) - 40) / viewModel.numberOfCellPerRow
        return CGSize.init(width:  width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
}
