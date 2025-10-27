import SwiftUI

class MatchPuzzlesViewModel: ObservableObject {
    let contact = MatchPuzzlesModel()
    @Published var slots: [[String]] = []
    @Published var coin =  UserDefaultsManager.shared.coins
    @Published var bet = 10
    let allFruits = ["puzzle1", "puzzle2", "puzzle3", "puzzle4", "puzzle5"]
    @Published var winningPositions: [(row: Int, col: Int)] = []
    @Published var isSpinning = false
    @Published var isStopSpininng = false
    @Published var isWin = false
    @Published var win = 0
    var spinningTimer: Timer?
    @Published var isGameStarted = false
    @Published var moves = 0
    @Published var score = 0
    @Published var selectedPositions: [(row: Int, col: Int)] = []

    init() {
        resetSlots()
    }
    
    func selectPosition(row: Int, col: Int) {
        guard isGameStarted else { return }
        if slots[row][col].isEmpty { return }

        if selectedPositions.count == 0 {
            selectedPositions.append((row, col))
        } else if selectedPositions.count == 1 {
            let first = selectedPositions[0]
            if first == (row, col) {
                return
            }
            selectedPositions.append((row, col))
            checkSelectedPair()
        }
    }

    func checkSelectedPair() {
        guard selectedPositions.count == 2 else { return }
        let first = selectedPositions[0]
        let second = selectedPositions[1]

        if slots[first.row][first.col] == slots[second.row][second.col] {
            slots[first.row][first.col] = ""
            slots[second.row][second.col] = ""
            score += 10
        }

        moves += 1
        selectedPositions.removeAll()
        checkGameOver()
    }

    func checkGameOver() {
        let remaining = slots.flatMap { $0 }.filter { !$0.isEmpty }.count
        if remaining == 0 {
            isGameStarted = false
            UserDefaultsManager.shared.addProgress(10)
            UserDefaultsManager.shared.addActivity(GameActivity(gameName: "Match-3 Puzzle", amount: 180))
        } else {
            if !hasAvailablePairs() {
                isGameStarted = false
                UserDefaultsManager.shared.addProgress(10)
                UserDefaultsManager.shared.addActivity(GameActivity(gameName: "Match-3 Puzzle", amount: score * 10))
            }
        }
    }

    func hasAvailablePairs() -> Bool {
        var counts: [String: Int] = [:]
        for row in slots {
            for item in row where !item.isEmpty {
                counts[item, default: 0] += 1
            }
        }
        return counts.values.contains { $0 >= 2 }
    }

    
    @Published var betString: String = "10" {
        didSet {
            if let newBet = Int(betString), newBet > 0 {
                bet = newBet
            }
        }
    }
    let symbolArray = [
        Symbol(image: "puzzle1", value: "100"),
        Symbol(image: "puzzle2", value: "50"),
        Symbol(image: "puzzle3", value: "10")
    ]
    
    func resetSlots() {
        slots = (0..<6).map { _ in
            (0..<6).map { _ in
                allFruits.randomElement()!
                
            }
        }
    }
    
    
    
}
