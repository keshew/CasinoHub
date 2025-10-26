import SwiftUI

struct RoyalPalaceView: View {
    @StateObject var classicFruitModel =  RoyalPalaceViewModel()
    @State var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    let symbolArray = [Symbol(image: "royal1", value: "100"),
                       Symbol(image: "royal2", value: "50"),
                       Symbol(image: "royal3", value: "10")]
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Image(.bg)
                    .resizable()
                
                LinearGradient(colors: [Color(red: 102/255, green: 97/255, blue: 3/255),
                                        Color(red: 104/255, green: 85/255, blue: 13/255),
                                        Color(red: 76/255, green: 66/255, blue: 26/255)], startPoint: .top, endPoint: .bottom).opacity(0.7)
                
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
                    
                    Text("Royal Palace")
                        .FontSemiBold(size: 24, color: Color(red: 255/255, green: 215/255, blue: 0/255))
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
                            .fill(LinearGradient(colors: [Color(red: 231/255, green: 135/255, blue: 1/255),
                                                          Color(red: 255/255, green: 184/255, blue: 33/255),
                                                          Color(red: 245/255, green: 196/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 187/255, green: 131/255, blue: 52/255), lineWidth: 5)
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
                            .fill(LinearGradient(colors: [Color(red: 118/255, green: 139/255, blue: 22/255).opacity(0.7),
                                                          Color(red: 154/255, green: 154/255, blue: 23/255).opacity(0.6),
                                                          Color(red: 133/255, green: 126/255, blue: 44/255).opacity(0.7)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 181/255, green: 158/255, blue: 29/255).opacity(0.4), lineWidth: 5)
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
                                    .stroke(Color(red: 113/255, green: 88/255, blue: 38/255), lineWidth: 4)
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
                                                    .fill(LinearGradient(colors: [Color(red: 239/255, green: 250/255, blue: 17/255),
                                                                                  Color(red: 72/255, green: 85/255, blue: 7/255)], startPoint: .leading, endPoint: .trailing))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 234/255, green: 221/255, blue: 13/255).opacity(0.5), lineWidth: 3)
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
    RoyalPalaceView()
}

