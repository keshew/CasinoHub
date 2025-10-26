import SwiftUI

struct ScratchCardsView: View {
    @StateObject var viewModel =  ScratchCardsViewModel()
    @Environment(\.presentationMode) var presentationMode
    let columns = Array(repeating: GridItem(.fixed(70), spacing: 30), count: 3)
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Image(.bgFruit)
                    .resizable()
                
                LinearGradient(colors: [Color(red: 70/255, green: 25/255, blue: 14/255),
                                        Color(red: 66/255, green: 32/255, blue: 16/255),
                                        Color(red: 68/255, green: 22/255, blue: 18/255)], startPoint: .top, endPoint: .bottom).opacity(0.7)
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
                    Text("Scratch Card")
                        .FontSemiBold(size: 24)
                    
                    Text("Scratch to reveal hidden prizes!")
                        .FontRegular(size: 16, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 116/255, green: 62/255, blue: 14/255).opacity(0.6),
                                                          Color(red: 151/255, green: 60/255, blue: 6/255).opacity(0.6)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 253/255, green: 199/255, blue: 2/255).opacity(0.3), lineWidth: 5)
                                    .overlay {
                                        HStack(spacing: 22) {
                                            VStack(spacing: 4) {
                                                Image(.achev)
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                
                                                Text("Current Win")
                                                    .FontRegular(size: 14, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                
                                                Text("\(viewModel.win)")
                                                    .FontRegular(size: 20)
                                            }
                                            
                                            Rectangle()
                                                .fill(Color(red: 254/255, green: 223/255, blue: 33/255).opacity(0.3))
                                                .frame(width: 1, height: 48)
                                            
                                            VStack(spacing: 4) {
                                                Image(.starYellow)
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                
                                                Text("Scratched")
                                                    .FontRegular(size: 14, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                
                                                Text("\(viewModel.screatched)/6")
                                                    .FontRegular(size: 20)
                                            }
                                        }
                                    }
                            }
                            .frame(height: 128)
                            .cornerRadius(18)
                            .padding(.horizontal)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 22/255, green: 26/255, blue: 40/255).opacity(0.7),
                                                          Color(red: 30/255, green: 41/255, blue: 57/255).opacity(0.7)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 253/255, green: 199/255, blue: 2/255).opacity(0.3), lineWidth: 5)
                                    .overlay {
                                        VStack(spacing: 10) {
                                            LazyVGrid(columns: columns, spacing: 10) {
                                                ForEach(viewModel.cards.indices, id: \.self) { index in
                                                    let card = viewModel.cards[index]
                                                    Button(action: {
                                                        viewModel.openCard(at: index)
                                                    }) {
                                                        if card.isOpened {
                                                            Rectangle()
                                                                .fill(
                                                                    LinearGradient(
                                                                        colors: [Color(red: 69/255, green: 68/255, blue: 65/255),
                                                                                 Color(red: 58/255, green: 54/255, blue: 53/255)],
                                                                        startPoint: .topLeading,
                                                                        endPoint: .bottomTrailing
                                                                    )
                                                                )
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 14)
                                                                        .stroke(Color(red: 255/255, green: 184/255, blue: 0/255).opacity(0.5), lineWidth: 3)
                                                                        .overlay(
                                                                            VStack {
                                                                                Image(card.image)
                                                                                    .resizable()
                                                                                    .aspectRatio(contentMode: .fit)
                                                                                    .frame(width: 63, height: 63)
                                                                            }
                                                                        )
                                                                }
                                                                .frame(width: 88, height: 88)
                                                                .cornerRadius(14)
                                                                .padding(.horizontal, 5)
                                                                .shadow(color: viewModel.winningIndexes.contains(index) ? Color.yellow.opacity(0.8) : Color.clear, radius: 10)
                                                        } else {
                                                            Rectangle()
                                                                .fill(
                                                                    LinearGradient(
                                                                        colors: [Color(red: 225/255, green: 113/255, blue: 0/255),
                                                                                 Color(red: 245/255, green: 73/255, blue: 1/255)],
                                                                        startPoint: .topLeading,
                                                                        endPoint: .bottomTrailing
                                                                    )
                                                                )
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 14)
                                                                        .stroke(Color.white.opacity(0.3), lineWidth: 3)
                                                                        .overlay(
                                                                            VStack {
                                                                                Image(.giftWhite)
                                                                                    .resizable()
                                                                                    .aspectRatio(contentMode: .fit)
                                                                                    .frame(width: 32, height: 32)
                                                                                
                                                                                Text("Scratch")
                                                                                    .FontRegular(size: 12, color: .white.opacity(0.6))
                                                                            }
                                                                        )
                                                                }
                                                                .frame(width: 88, height: 88)
                                                                .cornerRadius(14)
                                                                .padding(.horizontal, 5)
                                                        }
                                                    }
                                                    .disabled(card.isOpened)
                                                }
                                            }
                                            .padding()
                                            .disabled(!viewModel.isPlaying)
                                            
                                            HStack(spacing: 5) {
                                                HStack(spacing: 0) {
                                                    Text("Match 3 ")
                                                        .FontRegular(size: 14, color: Color(red: 255/255, green: 240/255, blue: 133/255))
                                                    
                                                    Image(.gift)
                                                        .resizable()
                                                        .frame(width: 17, height: 18)
                                                }
                                                
                                                Text("symbols to win!")
                                                    .FontRegular(size: 14, color: Color(red: 255/255, green: 240/255, blue: 133/255))
                                            }
                                        }
                                    }
                            }
                            .frame(height: 377)
                            .cornerRadius(18)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        Button(action: {
                            viewModel.startGame()
                        }) {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 241/255, green: 177/255, blue: 0/255),
                                                              Color(red: 254/255, green: 154/255, blue: 2/255),
                                                              Color(red: 208/255, green: 135/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color(red: 239/255, green: 189/255, blue: 45/255), lineWidth: 3)
                                        .overlay {
                                            HStack {
                                                Image(.darkTheme)
                                                    .resizable()
                                                    .frame(width: 13, height: 13)
                                                
                                                Text("Buy Card (10 coins)")
                                                    .FontSemiBold(size: 18, color: .black)
                                                
                                                Image(.darkTheme)
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
                        .opacity(viewModel.isPlaying ? 0 : 1)
                        .disabled(viewModel.isPlaying)
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    ScratchCardsView()
}

