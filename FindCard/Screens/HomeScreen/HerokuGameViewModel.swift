import Foundation
// MARK: - MemoryGameDelegate

protocol HerokuGameDelegate {
    func memoryGameDidStart(game: Card)
    func memoryGame(game: Card, showCards cards: [Card])
    func memoryGame(game: Card, hideCards cards: [Card])
    func memoryGameDidEnd(game: Card)
}

struct HerokuGameViewModel {
    var allCardData: [Card] = []
    var revealedCardData: [Card] = []
    let numberOfCellPerRow = 3
    var totalPairs: Int
    var openCardData: [Card] = []
    let minimumCardNumber = 1
    let maxmimumCardNumber = 100
    mutating func resetGameData() {
        allCardData.removeAll()
        revealedCardData.removeAll()
        openCardData.removeAll()
        totalStpes = 0
        lastSelectedIndex = nil
        for _ in 1...self.totalPairs {
            let number = Int.random(in: minimumCardNumber ... maxmimumCardNumber)
            allCardData.append(Card.init(name: String(number)))
            allCardData.append(Card.init(name: String(number)))
        }
        allCardData.shuffle()
    }
    
    init(totalPair: Int) {
        self.totalPairs = totalPair
        resetGameData()
    }
    func getData(index: Int) -> Card {
        return allCardData[index]
    }
    func getStatus(index: Int) -> CardStatus {
        return allCardData[index].status
    }
    func setStaus(index: Int, status: CardStatus) {
        allCardData[index].status = status
    }
    func getTotalNumberOfCardData() -> Int {
        return allCardData.count
    }
    mutating func addDataIntoOpenCard(card: Card) {
        openCardData.append(card)
    }
    mutating func removeAlldataFromOpenCard() {
        openCardData.removeAll()
    }
    var isCardAlreadyOpend: Bool {
        return openCardData.count > 0
    }
    func isGameFinished() -> Bool {
        return allCardData.count == revealedCardData.count
    }
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
    var cardBackText: String {
        return "?"
    }
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
    mutating func increastTotalStep() {
        totalStpes += 1
    }
    private(set) var totalStpes: Int = 0
    var lastSelectedIndex: Int? = nil
}
class Card {
    var name: String
    var status: CardStatus = .back
    init(name: String) {
        self.name = name
    }
}
extension Array {
    mutating func shuffle() {
        for _ in 0...self.count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
