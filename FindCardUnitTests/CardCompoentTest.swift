//
//  CardCompoentTest.swift
//  FindCardUnitTests
//
//  Created by Varma Mukesh on 13/05/20.
//  Copyright © 2020 com.mukesh. All rights reserved.
//

import XCTest
@testable import FindCard

class CardCompoentTest: XCTestCase {
    var cardView: FCHerokuGameCardView?
    override func setUp() {
        cardView = FCHerokuGameCardView.init(frame: CGRect.init())
    }
    override func tearDown() {
        cardView = nil
    }
    func testInitialSetup() {
        XCTAssertNotNil(cardView?.symBolLabel)
        XCTAssertNotEqual(cardView?.symBolLabel.backgroundColor, cardView?.closedCardBGColor)
        XCTAssertNil(cardView?.symBolLabel.text)
    }
    func testBySettingTextProperty() {
        cardView?.text = "Hello"
        XCTAssertNotNil(cardView?.symBolLabel.text)
        XCTAssertFalse(cardView?.symBolLabel.text?.isEmpty ?? true)
    }
    func testByChangingStatus() {
        cardView?.status = .front
        XCTAssertEqual(cardView?.symBolLabel.backgroundColor, cardView?.openCardBGColor)
        cardView?.status = .resloved
        XCTAssertEqual(cardView?.symBolLabel.backgroundColor, cardView?.openCardBGColor)
    }
}
