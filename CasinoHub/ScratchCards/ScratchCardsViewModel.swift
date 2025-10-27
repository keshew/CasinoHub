import SwiftUI

struct Card {
    let id = UUID()
    let image: String
    var isOpened = false
}

class ScratchCardsViewModel: ObservableObject {
    @Published var cards: [Card] = [Card(image: "scratch1")]
    @Published var isWin = false
    @Published var winningIndexes: [Int] = []
    @Published var balance = UserDefaultsManager.shared.coins
    @Published var bet = 10
    @Published var win = 0
    @Published var screatched = 0
    @Published var isPlaying = false
    
    init() {
        resetCards()
    }
    
    func resetCards() {
        cards = [
            Card(image: "scratch1"), Card(image: "scratch2"), Card(image: "scratch3"),
            Card(image: "scratch4"), Card(image: "scratch4"), Card(image: "scratch4"),
            Card(image: "scratch2"), Card(image: "scratch2"), Card(image: "scratch3")
        ]
        cards.shuffle()
        isWin = false
        winningIndexes = []
        win = 0
        screatched = 0
        isPlaying = false
    }
    
    func startGame() {
        guard balance >= bet else { return }
        UserDefaultsManager.shared.removeCoins(bet)
        balance = UserDefaultsManager.shared.coins
        resetCards()
        isPlaying = true
    }
    
    func openCard(at index: Int) {
        guard isPlaying else { return }
        guard !cards[index].isOpened else { return }
        
        cards[index].isOpened = true
        screatched += 1
        checkForWin()
        checkForGameEnd()
    }
    
    private func checkForWin() {
        let openedScratch4Indexes = cards.enumerated().filter { $0.element.isOpened && $0.element.image == "scratch4" }.map { $0.offset }
        
        if openedScratch4Indexes.count == 3 {
            isWin = true
            winningIndexes = openedScratch4Indexes
            win = bet * 10
            UserDefaultsManager.shared.addActivity(GameActivity(gameName: "Mines", amount: win))
            UserDefaultsManager.shared.addCoins(win)
            balance = UserDefaultsManager.shared.coins
            UserDefaultsManager.shared.addActivity(GameActivity(gameName: "Scratch Cards", amount: bet))
        } else {
            isWin = false
            winningIndexes = []
            win = 0
        }
    }
    
    private func checkForGameEnd() {
        if isWin || screatched >= 6 {
            isPlaying = false
        }
    }
}

