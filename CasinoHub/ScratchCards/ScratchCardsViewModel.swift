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
    @Published var balance = 1000
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
        balance -= bet
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
            balance += win
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

