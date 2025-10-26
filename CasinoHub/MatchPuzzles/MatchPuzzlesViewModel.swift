import SwiftUI

class MatchPuzzlesViewModel: ObservableObject {
    let contact = MatchPuzzlesModel()
    @Published var slots: [[String]] = []
    @Published var coin =  1000
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
        } else {
            if !hasAvailablePairs() {
                isGameStarted = false
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
    
    func spin() {
        
        
        coin -= bet
        isSpinning = true
        spinningTimer?.invalidate()
        winningPositions.removeAll()
        win = 0
        
        let columns = 6
        for col in 0..<columns {
            let delay = Double(col) * 0.4
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                var spinCount = 0
                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    for row in 0..<6 {
                        self.slots[row][col] = self.allFruits.randomElement()!
                    }
                    spinCount += 1
                    if spinCount > 12 + col * 4 {
                        timer.invalidate()
                        if col == columns - 1 {
                            self.isSpinning = false
                            self.checkWin()
                            
                        }
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            }
        }
    }
    
    
    func checkWin() {
        winningPositions = []
        var totalWin = 0
        var maxMultiplier = 0
        let minCounts = [
            "puzzle1": 5,
            "puzzle2": 5,
            "puzzle3": 5
        ]
        let multipliers = [
            "puzzle1": 100,
            "puzzle2": 50,
            "puzzle3": 10
        ]
        
        for row in 0..<3 {
            let rowContent = slots[row]
            var currentSymbol = rowContent[0]
            var count = 1
            for col in 1..<rowContent.count {
                if rowContent[col] == currentSymbol {
                    count += 1
                } else {
                    if let minCount = minCounts[currentSymbol], count >= minCount {
                        totalWin += multipliers[currentSymbol] ?? 0
                        if let multiplierValue = multipliers[currentSymbol], multiplierValue > maxMultiplier {
                            maxMultiplier = multiplierValue
                        }
                        let startCol = col - count
                        for c in startCol..<col {
                            winningPositions.append((row: row, col: c))
                        }
                    }
                    currentSymbol = rowContent[col]
                    count = 1
                }
            }
            if let minCount = minCounts[currentSymbol], count >= minCount {
                totalWin += multipliers[currentSymbol] ?? 0
                if let multiplierValue = multipliers[currentSymbol], multiplierValue > maxMultiplier {
                    maxMultiplier = multiplierValue
                }
                let startCol = rowContent.count - count
                for c in startCol..<rowContent.count {
                    winningPositions.append((row: row, col: c))
                }
            }
        }
        
        if totalWin != 0 {
            coin -= bet
            win = (totalWin + bet)
            isWin = true
        }
    }
}
