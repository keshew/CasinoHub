import SwiftUI

struct MatchPuzzlesView: View {
    @StateObject var viewModel =  MatchPuzzlesViewModel()
    @Environment(\.presentationMode) var presentationMode
    let columns = Array(repeating: GridItem(.fixed(70), spacing: 0), count: 5)
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Image(.bg)
                    .resizable()
                
                LinearGradient(colors: [Color(red: 15/255, green: 51/255, blue: 69/255),
                                        Color(red: 24/255, green: 36/255, blue: 86/255),
                                        Color(red: 14/255, green: 47/255, blue: 46/255)], startPoint: .top, endPoint: .bottom).opacity(0.7)
            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
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
                                        
                                        Text("\(viewModel.balance)")
                                            .FontRegular(size: 16, color: Color(red: 255/255, green: 249/255, blue: 194/255))
                                    }
                                }
                        }
                        .frame(width: 111, height: 48)
                        .cornerRadius(20)
                }
                .padding(.horizontal)
                
                VStack(spacing: 8) {
                    Text("Mines Game")
                        .FontSemiBold(size: 24)
                    
                    Text("Click tiles to reveal coins, avoid the mines!")
                        .FontRegular(size: 16, color: Color(red: 83/255, green: 234/255, blue: 253/255))
                }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack(spacing: 16) {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 15/255, green: 78/255, blue: 99/255).opacity(0.6),
                                                              Color(red: 1/255, green: 95/255, blue: 120/255).opacity(0.6)], startPoint: .top, endPoint: .bottom))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(Color(red: 0/255, green: 210/255, blue: 242/255).opacity(0.3), lineWidth: 5)
                                        .overlay {
                                            VStack(spacing: 4) {
                                                Image(.dollar)
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                
                                                Text("Current Win")
                                                    .FontRegular(size: 14, color: Color(red: 83/255, green: 234/255, blue: 253/255))
                                                
                                                Text("\(viewModel.win)")
                                                    .FontRegular(size: 20)
                                            }
                                        }
                                }
                                .frame(height: 128)
                                .cornerRadius(18)
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 28/255, green: 57/255, blue: 142/255).opacity(0.6),
                                                              Color(red: 24/255, green: 60/255, blue: 184/255).opacity(0.6)], startPoint: .top, endPoint: .bottom))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(Color(red: 81/255, green: 162/255, blue: 255/255).opacity(0.3), lineWidth: 5)
                                        .overlay {
                                            VStack(spacing: 4) {
                                                Image(.mult)
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                
                                                Text("Multiplier")
                                                    .FontRegular(size: 14, color: Color(red: 141/255, green: 197/255, blue: 255/255))
                                                
                                                Text("\(viewModel.correctAnswersCount)")
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
                                    .stroke(Color(red: 253/255, green: 199/255, blue: 2/255).opacity(0.3), lineWidth: 5)
                                    .overlay {
                                        VStack(spacing: 10) {
                                            LazyVGrid(columns: columns, spacing: 16) {
                                                ForEach(viewModel.cards.indices, id: \.self) { index in
                                                    let card = viewModel.cards[index]
                                                    Button(action: {
                                                        viewModel.openCard(at: index)
                                                    }) {
                                                        if card.isOpened {
                                                            Rectangle()
                                                                .fill(
                                                                    LinearGradient(
                                                                        colors: card.isBomb
                                                                        ? [Color.red.opacity(0.8), Color.red.opacity(0.6)]
                                                                        : [Color.green.opacity(0.7), Color.green.opacity(0.4)],
                                                                        startPoint: .topLeading,
                                                                        endPoint: .bottomTrailing
                                                                    )
                                                                )
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 14)
                                                                        .stroke(
                                                                            card.isBomb
                                                                            ? Color.red.opacity(0.9)
                                                                            : Color.green.opacity(0.9),
                                                                            lineWidth: 3
                                                                        )
                                                                        .overlay(
                                                                            Image(card.image)
                                                                                .resizable()
                                                                                .aspectRatio(contentMode: .fit)
                                                                                .frame(width: 38, height: 42)
                                                                        )
                                                                }
                                                                .frame(width: 50, height: 50)
                                                                .cornerRadius(14)
                                                                .padding(.horizontal, 5)
                                                                .shadow(
                                                                    color: card.isBomb
                                                                    ? Color.red.opacity(0.8)
                                                                    : Color.green.opacity(0.7),
                                                                    radius: 10
                                                                )
                                                        } else {
                                                            Rectangle()
                                                                .fill(
                                                                    LinearGradient(
                                                                        colors: [Color.white.opacity(0.2), Color.white.opacity(0.1)],
                                                                        startPoint: .topLeading,
                                                                        endPoint: .bottomTrailing
                                                                    )
                                                                )
                                                                .overlay(
                                                                    RoundedRectangle(cornerRadius: 16)
                                                                        .stroke(Color.white.opacity(0.3), lineWidth: 3)
                                                                        .overlay(
                                                                            Text("?")
                                                                                .FontRegular(size: 24, color: .white.opacity(0.4))
                                                                        )
                                                                )
                                                                .frame(width: 50, height: 50)
                                                                .cornerRadius(16)
                                                                .padding(.horizontal, 5)
                                                        }
                                                    }
                                                    .disabled(card.isOpened || !viewModel.isPlaying)
                                                }
                                            }
                                            .padding()
                                            .disabled(!viewModel.isPlaying)
                                        }
                                    }
                            }
                            .frame(height: 312)
                            .cornerRadius(18)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        Button(action: {
                            if viewModel.isPlaying {
                                viewModel.getReward()
                            } else {
                                viewModel.startGame()
                            }
                        }) {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 1/255, green: 146/255, blue: 184/255),
                                                              Color(red: 21/255, green: 93/255, blue: 251/255),
                                                              Color(red: 1/255, green: 150/255, blue: 138/255)], startPoint: .leading, endPoint: .trailing))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color(red: 0/255, green: 210/255, blue: 242/255).opacity(0.5), lineWidth: 3)
                                        .overlay {
                                            HStack {
                                                Image(.whiteTheme)
                                                    .resizable()
                                                    .frame(width: 13, height: 13)
                                                
                                                Text(viewModel.isPlaying ? "Get Reward" : "Start Game (\(viewModel.bet) coins)")
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

