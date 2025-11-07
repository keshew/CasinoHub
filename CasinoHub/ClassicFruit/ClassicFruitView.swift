import SwiftUI

struct ClassicFruitView: View {
    @StateObject var classicFruitModel =  ClassicFruitViewModel()
    @State var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    let symbolArray = [Symbol(image: "fruit1", value: "100"),
                       Symbol(image: "fruit2", value: "50"),
                       Symbol(image: "fruit3", value: "10")]
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Image(.bgFruit)
                    .resizable()
                
                LinearGradient(colors: [Color(red: 60/255, green: 15/255, blue: 102/255),
                                        Color(red: 46/255, green: 20/255, blue: 104/255),
                                        Color(red: 30/255, green: 26/255, blue: 138/255)], startPoint: .top, endPoint: .bottom).opacity(0.7)
                
                Rectangle()
                    .fill(.black.opacity(0.5))
                    .frame(height: 130)
                    .clipShape(
                        RoundedCorners(radius: 12, corners: [.allCorners])
                    )
            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        ZStack {
                            Circle()
                                .fill(.white.opacity(0.2))
                                .frame(width: 36, height: 36)
                            
                            Circle()
                                .fill(.white.opacity(0.2))
                                .frame(width: 32, height: 32)
                            
                            Image(systemName: "arrow.left")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                    }
                    
                    Spacer()
                    
                    Text("Classic Fruits")
                        .FontSemiBold(size: 24, color: Color(red: 255/255, green: 2/255, blue: 204/255))
                        .shadow(radius: 2, y: 5)
                        .padding(.trailing)
                    
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
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 232/255, green: 0/255, blue: 12/255),
                                                          Color(red: 255/255, green: 32/255, blue: 86/255),
                                                          Color(red: 245/255, green: 73/255, blue: 1/255)], startPoint: .leading, endPoint: .trailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 229/255, green: 57/255, blue: 73/255), lineWidth: 5)
                                    .overlay {
                                        Text("Win:\(classicFruitModel.win)")
                                            .FontRegular(size: 26, color: Color(red: 255/255, green: 215/255, blue: 0/255))
                                            .outlineText(color: .white, width: 0.4)
                                    }
                            }
                            .frame(height: 60)
                            .cornerRadius(18)
                            .padding(.horizontal)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 89/255, green: 22/255, blue: 139/255).opacity(0.7),
                                                          Color(red: 77/255, green: 24/255, blue: 154/255).opacity(0.6),
                                                          Color(red: 49/255, green: 44/255, blue: 132/255).opacity(0.7)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 128/255, green: 67/255, blue: 152/255), lineWidth: 5)
                                    .overlay {
                                        VStack(spacing: 20) {
                                            ForEach(0..<3, id: \.self) { row in
                                                HStack(spacing: 0) {
                                                    ForEach(0..<5, id: \.self) { col in
                                                        Rectangle()
                                                            .fill(
                                                                LinearGradient(
                                                                    colors: [Color.black.opacity(0.2)],
                                                                    startPoint: .topLeading,
                                                                    endPoint: .bottomTrailing
                                                                )
                                                            )
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 14)
                                                                    .stroke(Color.white.opacity(0.3), lineWidth: 3)
                                                                    .overlay(
                                                                        Image(classicFruitModel.slots[row][col])
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fit)
                                                                            .frame(width: 46, height: 46)
                                                                    )
                                                            }
                                                            .frame(width: 57, height: 58)
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
                            .frame(height: 276)
                            .cornerRadius(18)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 22/255, green: 26/255, blue: 40/255).opacity(0.7),
                                                          Color(red: 30/255, green: 41/255, blue: 57/255).opacity(0.7)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 93/255, green: 62/255, blue: 121/255), lineWidth: 4)
                                    .overlay {
                                        HStack(alignment: .bottom, spacing: 20) {
                                            Button(action: {
                                                if classicFruitModel.bet >= 50 {
                                                    classicFruitModel.bet -= 50
                                                }
                                            }) {
                                                Image(.minus)
                                                    .resizable()
                                                    .frame(width: 33, height: 33)
                                            }
                                            
                                            VStack(spacing: 5) {
                                                HStack {
                                                    Image(.themePurple)
                                                        .resizable()
                                                        .frame(width: 20, height: 20)
                                                    
                                                    Text("Select Bet")
                                                        .FontRegular(size: 16)
                                                }
                                                
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [Color(red: 152/255, green: 16/255, blue: 251/255),
                                                                                  Color(red: 127/255, green: 34/255, blue: 254/255)], startPoint: .leading, endPoint: .trailing))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 194/255, green: 122/255, blue: 255/255).opacity(0.5), lineWidth: 3)
                                                            .overlay {
                                                                Text("\(classicFruitModel.bet)")
                                                                    .FontRegular(size: 16)
                                                            }
                                                    }
                                                    .frame(width: 155, height: 32)
                                                    .cornerRadius(16)
                                            }
                                            
                                            Button(action: {
                                                if classicFruitModel.bet <= (classicFruitModel.coin - 50) {
                                                    classicFruitModel.bet += 50
                                                }
                                            }) {
                                                Image(.plus)
                                                    .resizable()
                                                    .frame(width: 33, height: 33)
                                            }
                                        }
                                    }
                            }
                            .frame(height: 77)
                            .cornerRadius(18)
                            .padding(.horizontal)
                            .padding(.top, 32)
                        
                        Button(action: {
                            if classicFruitModel.coin >= classicFruitModel.bet {
                                classicFruitModel.spin()
                            }
                        }) {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 241/255, green: 177/255, blue: 0/255),
                                                              Color(red: 254/255, green: 154/255, blue: 2/255),
                                                              Color(red: 208/255, green: 135/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color(red: 239/255, green: 189/255, blue: 45/255), lineWidth: 3)
                                        .overlay {
                                            Text("SPIN")
                                                .FontSemiBold(size: 30, color: .black)
                                        }
                                }
                                .frame(height: 68)
                                .cornerRadius(24)
                                .padding(.horizontal)
                                .padding(.top, 32)
                        }
                        .disabled(classicFruitModel.isSpinning)
                    }
                    .padding(.top)
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    ClassicFruitView()
}

struct RoundedCorners: Shape {
    var radius: CGFloat = 8
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func outlineText(color: Color, width: CGFloat) -> some View {
        modifier(StrokeModifier(strokeSize: width, strokeColor: color))
    }
}

struct StrokeModifier: ViewModifier {
    private let id = UUID()
    var strokeSize: CGFloat = 1
    var strokeColor: Color = .blue
    
    func body(content: Content) -> some View {
        content
            .padding(strokeSize*2)
            .background (Rectangle()
                .foregroundStyle(strokeColor)
                .mask({
                    outline(context: content)
                })
            )}
    
    func outline(context:Content) -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.01))
            context.drawLayer { layer in
                if let text = context.resolveSymbol(id: id) {
                    layer.draw(text, at: .init(x: size.width/2, y: size.height/2))
                }
            }
        } symbols: {
            context.tag(id)
                .blur(radius: strokeSize)
        }
    }
}

struct Symbol: Identifiable {
    var id = UUID().uuidString
    var image: String
    var value: String
}

class ClassicFruitViewModel: ObservableObject {
    @Published var slots: [[String]] = []
    @Published var coin =  UserDefaultsManager.shared.coins
    @Published var bet = 10
    let allFruits = ["fruit1", "fruit2", "fruit3"]
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
        Symbol(image: "rush1", value: "100"),
        Symbol(image: "rush2", value: "50"),
        Symbol(image: "rush3", value: "10")
    ]
    
    func resetSlots() {
        slots = (0..<3).map { _ in
            (0..<5).map { _ in
                allFruits.randomElement()!
            }
        }
    }
    
    func spin() {
        UserDefaultsManager.shared.removeCoins(bet)
        UserDefaultsManager.shared.setFirstGamePlayed()
        UserDefaultsManager.shared.incrementTotalGames()
        coin =  UserDefaultsManager.shared.coins
        isSpinning = true
        spinningTimer?.invalidate()
        winningPositions.removeAll()
        win = 0
        UserDefaultsManager.shared.addActivity(GameActivity(gameName: "Classic Fruits", amount: -bet))
        UserDefaultsManager.shared.addProgress(10)
        let columns = 5
        for col in 0..<columns {
            let delay = Double(col) * 0.4
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                var spinCount = 0
                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    for row in 0..<3 {
                        withAnimation(.spring(response: 0.1, dampingFraction: 1.5, blendDuration: 0)) {
                            self.slots[row][col] = self.allFruits.randomElement()!
                        }
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
            "fruit1": 5,
            "fruit2": 5,
            "fruit3": 5
        ]
        let multipliers = [
            "fruit1": 100,
            "fruit2": 50,
            "fruit3": 10
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
            win = totalWin
            isWin = true
            UserDefaultsManager.shared.addCoins(totalWin)
            coin = UserDefaultsManager.shared.coins
            UserDefaultsManager.shared.addActivity(GameActivity(gameName: "Classic Fruits", amount: totalWin))
        }
    }
}
