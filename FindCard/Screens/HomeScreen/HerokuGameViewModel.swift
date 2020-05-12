import Foundation
struct HerokuGameViewModel {
    var allCardData: [String] = []
    let numberOfCellPerRow = 3
    var openCardData: [String] = []
    init() {
        var arr: [String] = []
        for index in 1...6 {
            arr.append(String(index))
        }
        allCardData.append(contentsOf: arr)
        allCardData.append(contentsOf: arr)
    }
    func getData(index: Int) -> String {
        return allCardData[index]
    }
    func getTotalNumberOfCardData() -> Int {
        return allCardData.count
    }
    mutating func addDataIntoOpenCard(text: String) {
        openCardData.append(text)
    }
    mutating func removeAlldataFromOpenCard() {
        openCardData.removeAll()
    }
    mutating func isPairMatched() -> Bool {
        if self.openCardData.count == 2 {
            let matched = (self.openCardData[0] == self.openCardData[1])
            if matched {
                self.removeAlldataFromOpenCard()
            }
            return matched
        }
        return false
    }
    var lastSelectedIndex: Int? = nil
}
class Card {
    var id: String
    var shown: Bool = false
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
