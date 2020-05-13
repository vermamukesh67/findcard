//
//  FCHerokuGameCardViewTest.swift
//  FindCardUnitTests
//
//  Created by Varma Mukesh on 13/05/20.
//  Copyright © 2020 com.mukesh. All rights reserved.
//

import XCTest
@testable import FindCard

class FCHerokuGameCardViewTest: XCTestCase {
    var viewModel: HerokuGameViewModel?
    override func setUp() {
        viewModel = HerokuGameViewModel(totalPair: 6)
    }
    override func tearDown() {
        viewModel = nil
    }
    func testInitalViewModelSetup() {
        XCTAssertEqual(viewModel?.totalPairs, 6, "Pairs are incorrect")
        XCTAssertEqual(viewModel?.numberOfCardPerRow, 3, "numbers of cards are incorrect")
        XCTAssertEqual(viewModel?.allCardData.count, 12, "Data is incorrect")
        XCTAssertEqual(viewModel?.openCardData.count, 0, "Data is incorrect")
        XCTAssertEqual(viewModel?.revealedCardData.count, 0, "Data is incorrect")
        XCTAssertEqual(viewModel?.minimumCardNumber, 1, "its should be 1")
        XCTAssertEqual(viewModel?.maxmimumCardNumber, 100, "its should be 1")
        XCTAssertEqual(viewModel?.totalStpes, 0, "its should be 1")
        XCTAssertNil(viewModel?.lastSelectedIndex, "it should be nil")
        XCTAssertFalse(viewModel?.isCardAlreadyOpend() ?? true)
        XCTAssertFalse(viewModel?.isPlaying ?? true)
        XCTAssertFalse(viewModel?.isGameFinished() ?? true)
        XCTAssertFalse(viewModel?.isPairMatched() ?? true)
        let max = viewModel?.allCardData.max { $0.name < $1.name }?.name ?? ""
        XCTAssertLessThanOrEqual(Int(max) ?? 0, viewModel?.maxmimumCardNumber ?? 1, "numbers must be between min and max")
    }
    func testResetGameFeature() {
        viewModel?.resetGameData()
        XCTAssertEqual(viewModel?.totalPairs, 6, "Pairs are incorrect")
        XCTAssertEqual(viewModel?.numberOfCardPerRow, 3, "numbers of cards are incorrect")
        XCTAssertEqual(viewModel?.allCardData.count, 12, "Data is incorrect")
        XCTAssertEqual(viewModel?.openCardData.count, 0, "Data is incorrect")
        XCTAssertEqual(viewModel?.revealedCardData.count, 0, "Data is incorrect")
        XCTAssertEqual(viewModel?.minimumCardNumber, 1, "its should be 1")
        XCTAssertEqual(viewModel?.maxmimumCardNumber, 100, "its should be 1")
        XCTAssertEqual(viewModel?.totalStpes, 0, "its should be 1")
        XCTAssertNil(viewModel?.lastSelectedIndex, "it should be nil")
        XCTAssertFalse(viewModel?.isCardAlreadyOpend() ?? true)
        XCTAssertFalse(viewModel?.isPlaying ?? true)
        XCTAssertFalse(viewModel?.isGameFinished() ?? true)
        XCTAssertFalse(viewModel?.isPairMatched() ?? true)
        let max = viewModel?.allCardData.max { $0.name < $1.name }?.name ?? ""
        XCTAssertLessThanOrEqual(Int(max) ?? 0, viewModel?.maxmimumCardNumber ?? 1, "numbers must be between min and max")
    }
    func testByUpdatingStatus() {
        viewModel?.updateCardStatus(index: 0)
        XCTAssertEqual(viewModel?.getStatus(index: 0), CardStatus.front, "its should be front")
        viewModel?.updateCardStatus(index: 0)
        XCTAssertEqual(viewModel?.getStatus(index: 0), CardStatus.back, "its should be front")
        viewModel?.setStaus(index: 0, status: CardStatus.resloved)
        viewModel?.updateCardStatus(index: 0)
        XCTAssertEqual(viewModel?.getStatus(index: 0), CardStatus.resloved, "its should be resloved")
    }
    func testPairMatchig() {
        let card1 = Card(name: "1")
        let card2 = Card(name: "1")
        viewModel?.addDataIntoOpenCard(card: card1)
        XCTAssertFalse(viewModel?.isPairMatched() ?? true)
        viewModel?.addDataIntoOpenCard(card: card2)
        XCTAssertTrue(viewModel?.isPairMatched() ?? false)
    }
    func testGameFinshed() {
        viewModel = HerokuGameViewModel(totalPair: 1)
        let card1 = Card(name: "1")
        let card2 = Card(name: "1")
        viewModel?.addDataIntoOpenCard(card: card1)
        XCTAssertFalse(viewModel?.isPairMatched() ?? true)
        XCTAssertFalse(viewModel?.isGameFinished() ?? true)
        viewModel?.addDataIntoOpenCard(card: card2)
        XCTAssertTrue(viewModel?.isPairMatched() ?? false)
        XCTAssertTrue(viewModel?.isGameFinished() ?? true)
    }
}
