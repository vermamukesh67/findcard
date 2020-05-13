//
//  FindCardUnitTests.swift
//  FindCardUnitTests
//
//  Created by Varma Mukesh on 13/05/20.
//  Copyright © 2020 com.mukesh. All rights reserved.
//

import XCTest
@testable import FindCard

class CardUnitTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testCardData() {
        let card = Card(name: "1")
        XCTAssertNotNil(card.name, "it should not be")
        XCTAssertEqual(card.status, CardStatus.back, "it should be back")
    }
    func testCardStatus() {
        let card = Card(name: "1")
        XCTAssertNotNil(card.name, "it should not be")
        XCTAssertEqual(card.status, CardStatus.back, "it should be back")
        card.status = .resloved
        XCTAssertEqual(card.status, CardStatus.resloved, "it should be resloved")
    }
}
