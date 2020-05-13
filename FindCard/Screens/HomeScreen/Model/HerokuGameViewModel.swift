import Foundation

/// Handle the game.
struct HerokuGameViewModel {
    private(set) var allCardData: [Card] = []
    private(set) var revealedCardData: [Card] = []
    private(set) var totalPairs: Int
    private(set) var openCardData: [Card] = []
    let minimumCardNumber = 1
    let maxmimumCardNumber = 100
    mutating func resetGameData() {
        allCardData.removeAll()
        revealedCardData.removeAll()
        openCardData.removeAll()
        totalStpes = 0
        lastSelectedIndex = nil
        for _ in 1...self.totalPairs {
            let number = Int(arc4random_uniform(UInt32(maxmimumCardNumber)) + UInt32(minimumCardNumber))//Int.random(in: minimumCardNumber ... maxmimumCardNumber)
            allCardData.append(Card.init(name: String(number)))
            allCardData.append(Card.init(name: String(number)))
        }
        allCardData.shuffle()
    }
    /// Init the game with total numbers of pair.
    /// - Parameter totalPair: Int value
    init(totalPair: Int) {
        self.totalPairs = totalPair
        resetGameData()
    }
    /// Get card data at index
    /// - Parameter index: Int value
    func getData(index: Int) -> Card {
        return allCardData[index]
    }
    /// Get the card status at index.
    /// - Parameter index: Int value
    func getStatus(index: Int) -> CardStatus {
        return allCardData[index].status
    }
    /// Sets the given statu value at index.
    /// - Parameters:
    ///   - index: Int value
    ///   - status: CardStatus value
    func setStaus(index: Int, status: CardStatus) {
        allCardData[index].status = status
    }
    /// Get the total numbers of card in the game.
    func getTotalNumberOfCardData() -> Int {
        return allCardData.count
    }
    /// Adds the card in open card array.
    /// - Parameter card: Card object.
    mutating func addDataIntoOpenCard(card: Card) {
        openCardData.append(card)
    }
    /// Removes all the open card data .
    mutating func removeAlldataFromOpenCard() {
        openCardData.removeAll()
    }
    /// Returns true if any card is already opened.
    func isCardAlreadyOpend() -> Bool {
        return openCardData.count > 0
    }
    /// Return true if all pair matched in game so that the game is finished.
    func isGameFinished() -> Bool {
        return allCardData.count == revealedCardData.count
    }
    /// Returns true if pair is matched for open cards.
    mutating func isPairMatched() -> Bool {
        if self.openCardData.count == 2 {
            let matched = (self.openCardData[0].name == self.openCardData[1].name)
            if matched {
                self.openCardData[0].status = .resloved
                self.openCardData[1].status = .resloved
                self.revealedCardData.append(self.openCardData[0])
                self.revealedCardData.append(self.openCardData[1])
            }
            self.removeAlldataFromOpenCard()
            return matched
        }
        return false
    }
    /// Returns the
    var cardBackText: String {
        return "?"
    }
    /// Update the card status automatically from back to front and front to back.
    /// - Parameter index: A Int value
    mutating func updateCardStatus(index: Int) {
        switch allCardData[index].status {
        case .back:
            allCardData[index].status = .front
        case .front:
            allCardData[index].status = .back
        default:
            break
        }
    }
    /// Auto increment the steps played.
    mutating func increastTotalStep() {
        totalStpes += 1
    }
    /// Returns the total step played.
    private(set) var totalStpes: Int = 0
    /// Stores the previous selected index in game,
    var lastSelectedIndex: Int?
    /// Returns true if game is playing.
    var isPlaying = false
    /// Returns the total number of card in each row.
    var numberOfCardPerRow = 3
}
