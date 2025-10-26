import SwiftUI

struct DiamondDeluxeView: View {
    @StateObject var classicFruitModel =  DiamondDeluxeViewModel()
    @State var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    let symbolArray = [Symbol(image: "diamond1", value: "100"),
                       Symbol(image: "diamond2", value: "50"),
                       Symbol(image: "diamond3", value: "10")]
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Image(.diamondBg)
                    .resizable()
                
                LinearGradient(colors: [Color(red: 94/255, green: 13/255, blue: 102/255),
                                        Color(red: 92/255, green: 17/255, blue: 104/255),
                                        Color(red: 76/255, green: 26/255, blue: 78/255)], startPoint: .top, endPoint: .bottom).opacity(0.7)
                
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
                    
                    Text("Diamond Deluxe")
                        .FontSemiBold(size: 24, color: Color(red: 22/255, green: 187/255, blue: 221/255))
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
                            .fill(LinearGradient(colors: [Color(red: 0/255, green: 184/255, blue: 219/255),
                                                          Color(red: 0/255, green: 166/255, blue: 244/255),
                                                          Color(red: 21/255, green: 93/255, blue: 251/255)], startPoint: .leading, endPoint: .trailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 52/255, green: 189/255, blue: 216/255), lineWidth: 5)
                                    .overlay {
                                        Text("Win:\(classicFruitModel.win)")
                                            .FontRegular(size: 26, color: Color(red: 4/255, green: 184/255, blue: 219/255))
                                            .outlineText(color: .white, width: 0.4)
                                    }
                            }
                            .frame(height: 60)
                            .cornerRadius(18)
                            .padding(.horizontal)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 0/255, green: 184/255, blue: 219/255).opacity(0.7),
                                                          Color(red: 23/255, green: 99/255, blue: 154/255).opacity(0.6),
                                                          Color(red: 45/255, green: 117/255, blue: 133/255).opacity(0.7)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 0/255, green: 184/255, blue: 219/255).opacity(0.4), lineWidth: 5)
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
                                    .stroke(Color(red: 26/255, green: 83/255, blue: 113/255), lineWidth: 4)
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
                                                    Image(.bluueTheme)
                                                        .resizable()
                                                        .frame(width: 20, height: 20)
                                                    
                                                    Text("Select Bet")
                                                        .FontRegular(size: 16)
                                                }
                                                
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [Color(red: 16/255, green: 152/255, blue: 250/255),
                                                                                  Color(red: 33/255, green: 214/255, blue: 254/255)], startPoint: .leading, endPoint: .trailing))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 0/255, green: 184/255, blue: 219/255).opacity(0.5), lineWidth: 3)
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
                                        .stroke(Color(red: 68/255, green: 180/255, blue: 157/255), lineWidth: 3)
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
    DiamondDeluxeView()
}

