import SwiftUI

class MagicSpinViewModel: ObservableObject {
    let contact = MagicSpinModel()
    @Published var slots: [[String]] = []
    @Published var coin =  1000
    @Published var bet = 10
    let allFruits = ["magic1", "magic2", "magic3"]
    @Published var winningPositions: [(row: Int, col: Int)] = []
    @Published var isSpinning = false
    @Published var isStopSpininng = false
    @Published var isWin = false
    @Published var win = 0
    var spinningTimer: Timer?
    
    init() {
        resetSlots()
    }
    
    @Published var betString: String = "10" {
        didSet {
            if let newBet = Int(betString), newBet > 0 {
                bet = newBet
            }
        }
    }
    let symbolArray = [
        Symbol(image: "magic1", value: "100"),
        Symbol(image: "magic2", value: "50"),
        Symbol(image: "magic3", value: "10")
    ]
    
    func resetSlots() {
        slots = (0..<3).map { _ in
            (0..<5).map { _ in
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
        
        let columns = 5
        for col in 0..<columns {
            let delay = Double(col) * 0.4
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                var spinCount = 0
                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    for row in 0..<3 {
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
            "magic1": 5,
            "magic2": 5,
            "magic3": 5
        ]
        let multipliers = [
            "magic1": 100,
            "magic2": 50,
            "magic3": 10
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
