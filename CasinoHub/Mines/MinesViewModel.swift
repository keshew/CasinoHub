import SwiftUI

class MinesViewModel: ObservableObject {
    struct Card: Identifiable {
        let id = UUID()
        let image: String
        var isOpened = false
        var isBomb: Bool {
            image == "bomb"
        }
    }
    
    @Published var cards: [Card] = []
    @Published var balance = 1000
    @Published var bet = 20
    @Published var win = 0
    @Published var isPlaying = false
    @Published var gameOver = false
    @Published var correctAnswersCount = 0

    init() {
        resetCards()
    }
    
    func resetCards() {
        let baseCards = (0..<20).map { _ in Card(image: Bool.random() ? "scratch2" : "bomb") }
        cards = baseCards.shuffled()
        win = 0
        gameOver = false
        isPlaying = false
    }

    func startGame() {
        guard balance >= bet else { return }
        balance -= bet
        resetCards()
        isPlaying = true
        gameOver = false
        correctAnswersCount = 0
        win = 0
    }

    func openCard(at index: Int) {
        guard isPlaying, !gameOver else { return }
        guard !cards[index].isOpened else { return }

        cards[index].isOpened = true

        if cards[index].isBomb {
            gameOver = true
            isPlaying = false
            win = 0
            correctAnswersCount = 0
        } else {
            correctAnswersCount += 1
            win += bet
        }
    }

    func getReward() {
        balance += win
        isPlaying = false
        gameOver = false
        win = 0
    }
}

