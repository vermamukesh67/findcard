//
//  HerokuGameCell.swift
//  FindCard
//
//  Created by Chandresh Maurya on 12/05/20.
//  Copyright © 2020 com.mukesh. All rights reserved.
//

import UIKit

class HerokuGameCell: UICollectionViewCell {
    @IBOutlet weak var gmaeView: FCHerokuGameCardView!
    let flipAnimationDuration = 0.5
    override func awakeFromNib() {
        super.awakeFromNib()
        gmaeView.backgroundColor = .red
    }
    func updateCell(text: String) {
        self.gmaeView.cardRevealedText = text
    }
}
