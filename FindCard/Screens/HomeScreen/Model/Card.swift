//
//  Card.swift
//  FindCard
//
//  Created by Varma Mukesh on 13/05/20.
//  Copyright © 2020 com.mukesh. All rights reserved.
//

import Foundation
/// Holds the card data.
class Card {
    var name: String
    var status: CardStatus = .back
    init(name: String) {
        self.name = name
    }
}
