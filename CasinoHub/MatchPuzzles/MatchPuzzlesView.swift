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

