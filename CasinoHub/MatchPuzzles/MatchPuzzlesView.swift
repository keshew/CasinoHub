import SwiftUI

struct MatchPuzzlesView: View {
    @StateObject var classicFruitModel =  MatchPuzzlesViewModel()
    @Environment(\.presentationMode) var presentationMode
    let columns = Array(repeating: GridItem(.fixed(70), spacing: 0), count: 5)
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Image(.bgFruit)
                    .resizable()
                
                LinearGradient(colors: [Color(red: 81/255, green: 15/255, blue: 36/255),
                                        Color(red: 77/255, green: 14/255, blue: 25/255),
                                        Color(red: 60/255, green: 15/255, blue: 102/255)], startPoint: .top, endPoint: .bottom).opacity(0.9)
            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
                    }) {
                        Rectangle()
                            .fill(.white.opacity(0.1))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white.opacity(0.2))
                                    .overlay {
                                        HStack {
                                            Image(systemName: "arrow.left")
                                                .foregroundStyle(.white)
                                                .font(.system(size: 16, weight: .bold))
                                            
                                            Text("Back")
                                                .FontSemiBold(size: 14)
                                        }
                                    }
                            }
                            .frame(width: 91, height: 36)
                            .cornerRadius(20)
                    }
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(Color(red: 253/255, green: 199/255, blue: 2/255).opacity(0.4))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(red: 194/255, green: 130/255, blue: 16/255), lineWidth: 3)
                                .overlay {
                                    HStack {
                                        Image(.coins)
                                            .resizable()
                                            .frame(width: 27, height: 27)
                                        
                                        Text("\(classicFruitModel.coin)")
                                            .FontRegular(size: 16, color: Color(red: 255/255, green: 249/255, blue: 194/255))
                                    }
                                }
                        }
                        .frame(width: 111, height: 48)
                        .cornerRadius(20)
                }
                .padding(.horizontal)
                
                VStack(spacing: 8) {
                    Text("Match-3 Puzzle")
                        .FontSemiBold(size: 24)
                    
                    Text("Match gems to earn points and win!")
                        .FontRegular(size: 16, color: Color(red: 253/255, green: 165/255, blue: 213/255))
                }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack(spacing: 16) {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 89/255, green: 22/255, blue: 139/255).opacity(0.6),
                                                              Color(red: 110/255, green: 17/255, blue: 176/255).opacity(0.6)], startPoint: .top, endPoint: .bottom))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(Color(red: 194/255, green: 122/255, blue: 255/255).opacity(0.3), lineWidth: 5)
                                        .overlay {
                                            VStack(spacing: 4) {
                                                Image(.scorePuzzle)
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                
                                                Text("Score")
                                                    .FontRegular(size: 14, color: Color(red: 217/255, green: 179/255, blue: 255/255))
                                                
                                                Text("\(classicFruitModel.score)")
                                                    .FontRegular(size: 20)
                                            }
                                        }
                                }
                                .frame(height: 128)
                                .cornerRadius(18)
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 134/255, green: 17/255, blue: 67/255).opacity(0.6),
                                                              Color(red: 163/255, green: 0/255, blue: 76/255).opacity(0.6)], startPoint: .top, endPoint: .bottom))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(Color(red: 251/255, green: 100/255, blue: 182/255).opacity(0.3), lineWidth: 5)
                                        .overlay {
                                            VStack(spacing: 4) {
                                                Image(.movePuzzle)
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                
                                                Text("Moves")
                                                    .FontRegular(size: 14, color: Color(red: 217/255, green: 179/255, blue: 255/255))
                                                
                                                Text("\(classicFruitModel.moves)")
                                                    .FontRegular(size: 20)
                                            }
                                        }
                                }
                                .frame(height: 128)
                                .cornerRadius(18)
                        }
                        .padding(.horizontal)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 22/255, green: 26/255, blue: 40/255).opacity(0.7),
                                                          Color(red: 30/255, green: 41/255, blue: 57/255).opacity(0.7)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 246/255, green: 51/255, blue: 154/255).opacity(0.3), lineWidth: 5)
                                    .overlay {
                                        VStack(spacing: 10) {
                                            ForEach(0..<6, id: \.self) { row in
                                                HStack(spacing: 0) {
                                                    ForEach(0..<6, id: \.self) { col in
                                                        Button(action: {
                                                            classicFruitModel.selectPosition(row: row, col: col)
                                                        }) {
                                                            Rectangle()
                                                                .fill(
                                                                    LinearGradient(
                                                                        colors: classicFruitModel.selectedPositions.contains(where: { $0.row == row && $0.col == col }) ?
                                                                        [Color.blue.opacity(0.6), Color.blue.opacity(0.3)] :
                                                                        [Color.black.opacity(0.2), Color.black.opacity(0.2)],
                                                                        startPoint: .topLeading,
                                                                        endPoint: .bottomTrailing
                                                                    )
                                                                )
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 14)
                                                                        .stroke(
                                                                            classicFruitModel.selectedPositions.contains(where: { $0.row == row && $0.col == col }) ?
                                                                            Color.blue.opacity(0.8) : Color.white.opacity(0.3),
                                                                            lineWidth: 3
                                                                        )
                                                                        .overlay(
                                                                            Image(classicFruitModel.slots[row][col])
                                                                                .resizable()
                                                                                .aspectRatio(contentMode: .fit)
                                                                                .frame(width: 23, height: 23)
                                                                        )
                                                                }
                                                                .frame(width: 41, height: 41)
                                                                .cornerRadius(14)
                                                                .padding(.horizontal, 5)
                                                                .shadow(
                                                                    color: classicFruitModel.winningPositions.contains(where: { $0.row == row && $0.col == col }) ? Color.white : .clear,
                                                                    radius: classicFruitModel.isSpinning ? 0 : 25
                                                                )
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                            }
                            .frame(height: 342)
                            .cornerRadius(18)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        Button(action: {
                            if classicFruitModel.coin >= 20 {
                                UserDefaultsManager.shared.removeCoins(20)
                                classicFruitModel.coin = UserDefaultsManager.shared.coins
                                classicFruitModel.isGameStarted = true
                                classicFruitModel.resetSlots()
                                classicFruitModel.moves = 0
                                classicFruitModel.score = 0
                                UserDefaultsManager.shared.incrementTotalGames()
                            }
                        }) {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 230/255, green: 0/255, blue: 117/255),
                                                              Color(red: 225/255, green: 32/255, blue: 86/255),
                                                              Color(red: 152/255, green: 16/255, blue: 251/255)], startPoint: .leading, endPoint: .trailing))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color(red: 251/255, green: 100/255, blue: 182/255).opacity(0.5), lineWidth: 3)
                                        .overlay {
                                            HStack {
                                                Image(.whiteTheme)
                                                    .resizable()
                                                    .frame(width: 13, height: 13)
                                                
                                                Text("Start")
                                                    .FontSemiBold(size: 18)
                                                
                                                Image(.whiteTheme)
                                                    .resizable()
                                                    .frame(width: 13, height: 13)
                                            }
                                        }
                                }
                                .frame(height: 68)
                                .cornerRadius(24)
                                .padding(.horizontal)
                                .padding(.top)
                        }
                        .opacity(classicFruitModel.isGameStarted ? 0 : 1)
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    MatchPuzzlesView()
}

class MatchPuzzlesViewModel: ObservableObject {
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
