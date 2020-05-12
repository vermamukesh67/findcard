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
    let numberOfCellPerRow = 3
    var totalPairs: Int
    var openCardData: [Card] = []
    let minimumCardNumber = 1
    let maxmimumCardNumber = 100
    init(totalPair: Int) {
        self.totalPairs = totalPair
        var arr: [Card] = []
        for _ in 1...totalPair {
            let number = Int.random(in: minimumCardNumber ... maxmimumCardNumber)
            arr.append(Card.init(name: String(number)))
            arr.append(Card.init(name: String(number)))
        }
        allCardData.append(contentsOf: arr)
        allCardData.shuffle()
    }
    func getData(index: Int) -> Card {
        return allCardData[index]
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
    mutating func isPairMatched() -> Bool {
        if self.openCardData.count == 2 {
            let matched = (self.openCardData[0].name == self.openCardData[1].name)
            if matched {
                self.openCardData[0].status = .resloved
                self.openCardData[1].status = .resloved
                self.removeAlldataFromOpenCard()
            }
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
