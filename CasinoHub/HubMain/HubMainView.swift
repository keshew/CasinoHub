import SwiftUI

struct HubMainView: View {
    @StateObject var hubMainModel =  HubMainViewModel()
    @Binding var selectedTab: CustomTabBar.TabType
    @State var isMatch = false
    @State var isMines = false
    @State var isScratch = false
    @State private var level: Int = max(1, UserDefaultsManager.shared.level)
    @State private var progress: Int = UserDefaultsManager.shared.progress
    private let pointsPerLevel = 100
    
    private func progressBarWidth(proxyWidth: CGFloat) -> CGFloat {
        return CGFloat(progress) / CGFloat(pointsPerLevel) * proxyWidth
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 13/255, green: 18/255, blue: 24/255),
                                    Color(red: 60/255, green: 15/255, blue: 102/255),
                                    Color(red: 30/255, green: 26/255, blue: 77/255)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text("Casino Hub")
                        .FontRegular(size: 16)
                        .padding(.top)
                    
                    HStack(spacing: 4) {
                        Image(.star)
                            .resizable()
                            .frame(width: 16, height: 16)
                        
                        Text("Your premium gaming destination")
                            .FontRegular(size: 16, color: Color(red: 217/255, green: 179/255, blue: 255/255))
                        
                        Image(.star)
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                }
                
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(red: 89/255, green: 22/255, blue: 139/255),
                                                      Color(red: 49/255, green: 44/255, blue: 132/255),
                                                      Color(red: 89/255, green: 22/255, blue: 139/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 102/255, green: 50/255, blue: 147/255), lineWidth: 3)
                                .overlay {
                                    VStack(spacing: 28) {
                                        HStack {
                                            Rectangle()
                                                .fill(Color(red: 253/255, green: 199/255, blue: 2/255).opacity(0.2))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(red: 181/255, green: 130/255, blue: 43/255), lineWidth: 2)
                                                        .overlay {
                                                            HStack {
                                                                Image(.menu1)
                                                                    .resizable()
                                                                    .frame(width: 20, height: 20)
                                                                
                                                                Text("\(UserDefaultsManager.shared.coins)")
                                                                    .FontRegular(size: 16, color: Color(red: 255/255, green: 241/255, blue: 186/255))
                                                            }
                                                        }
                                                }
                                                .frame(height: 44)
                                                .cornerRadius(20)
                                            
//                                            Rectangle()
//                                                .fill(Color(red: 0/255, green: 210/255, blue: 242/255).opacity(0.2))
//                                                .overlay {
//                                                    RoundedRectangle(cornerRadius: 20)
//                                                        .stroke(Color(red: 13/255, green: 153/255, blue: 255/255), lineWidth: 2)
//                                                        .overlay {
//                                                            HStack {
//                                                                Image(.menu2)
//                                                                    .resizable()
//                                                                    .frame(width: 20, height: 20)
//                                                                
//                                                                Text("100")
//                                                                    .FontRegular(size: 16, color: Color(red: 188/255, green: 245/255, blue: 252/255))
//                                                            }
//                                                        }
//                                                }
//                                                .frame(height: 44)
//                                                .cornerRadius(20)
                                            
                                            Rectangle()
                                                .fill(Color(red: 194/255, green: 122/255, blue: 255/255).opacity(0.2))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(red: 149/255, green: 82/255, blue: 211/255), lineWidth: 2)
                                                        .overlay {
                                                            HStack {
                                                                Image(.menu3)
                                                                    .resizable()
                                                                    .frame(width: 20, height: 20)
                                                                
                                                                Text("Lvl \(level)")
                                                                    .FontRegular(size: 16, color: Color(red: 153/255, green: 133/255, blue: 172/255))
                                                            }
                                                        }
                                                }
                                                .frame(height: 44)
                                                .cornerRadius(20)
                                        }
                                        
                                        VStack(spacing: 8) {
                                            ZStack(alignment: .leading) {
                                                Rectangle()
                                                    .frame(height: 10)
                                                    .cornerRadius(5)
                                                    .foregroundColor(Color.gray.opacity(0.3))
                                                
                                                Rectangle()
                                                    .frame(width: progressBarWidth(proxyWidth: 300), height: 10)
                                                    .cornerRadius(5)
                                                    .foregroundColor(Color.purple)
                                            }
                                            .frame(height: 10)
                                            .frame(maxWidth: 338)

                                            
                                            HStack {
                                                Text("Experience")
                                                    .FontRegular(size: 12, color: Color(red: 217/255, green: 179/255, blue: 255/255))
                                                
                                                Spacer()
                                                
                                                Text("\(progress) / \(pointsPerLevel) XP")
                                                    .FontRegular(size: 12, color: Color(red: 217/255, green: 179/255, blue: 255/255))
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                        }
                        .frame(height: 164)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            HStack(spacing: 30) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 152/255, green: 16/255, blue: 251/255),
                                                                  Color(red: 127/255, green: 34/255, blue: 254/255),
                                                                  Color(red: 130/255, green: 2/255, blue: 219/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(red: 179/255, green: 84/255, blue: 251/255), lineWidth: 3)
                                            .overlay {
                                                VStack(alignment: .leading, spacing: 16) {
                                                    Image(.game1)
                                                        .resizable()
                                                        .frame(width: 56, height: 56)
                                                    
                                                    Text("Slot Machines")
                                                        .FontRegular(size: 16)
                                                    
                                                    Text("Spin the reels and win big")
                                                        .FontRegular(size: 16, color: Color(red: 230/255, green: 213/255, blue: 248/255))
                                                    
                                                    Button(action: {
                                                        selectedTab = .Slots
                                                    }) {
                                                        Rectangle()
                                                            .fill(Color(red: 137/255, green: 94/255, blue: 185/255).opacity(0.6))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 14)
                                                                    .stroke(Color(red: 196/255, green: 177/255, blue: 222/255), lineWidth: 3)
                                                                    .overlay {
                                                                        Text("Play")
                                                                            .FontSemiBold(size: 14)
                                                                    }
                                                            }
                                                            .frame(height: 36)
                                                            .cornerRadius(14)
                                                    }
                                                }
                                                .padding(.horizontal, 34)
                                            }
                                    }
                                    .frame(height: 252)
                                    .cornerRadius(24)
                                    .shadow(color: Color(red: 153/255, green: 72/255, blue: 241/255), radius: 15)
                                
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 230/255, green: 0/255, blue: 117/255),
                                                                  Color(red: 255/255, green: 32/255, blue: 86/255).opacity(0.7),
                                                                  Color(red: 198/255, green: 1/255, blue: 92/255).opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(red: 216/255, green: 67/255, blue: 113/255), lineWidth: 3)
                                            .overlay {
                                                VStack(alignment: .leading, spacing: 16) {
                                                    Image(.game2)
                                                        .resizable()
                                                        .frame(width: 56, height: 56)
                                                    
                                                    Text("Match-3")
                                                        .FontRegular(size: 16)
                                                    
                                                    Text("Match colorful gems")
                                                        .FontRegular(size: 16, color: Color(red: 248/255, green: 214/255, blue: 222/255))
                                                    
                                                    Button(action: {
                                                        isMatch = true
                                                    }) {
                                                        Rectangle()
                                                            .fill(Color(red: 137/255, green: 94/255, blue: 185/255).opacity(0.6))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 14)
                                                                    .stroke(Color(red: 196/255, green: 177/255, blue: 222/255), lineWidth: 3)
                                                                    .overlay {
                                                                        Text("Play")
                                                                            .FontSemiBold(size: 14)
                                                                    }
                                                            }
                                                            .frame(height: 36)
                                                            .cornerRadius(14)
                                                    }
                                                }
                                                .padding(.horizontal, 34)
                                            }
                                    }
                                    .frame(height: 252)
                                    .cornerRadius(24)
                                    .shadow(color: Color(red: 216/255, green: 67/255, blue: 113/255), radius: 15)
                            }
                            
                            HStack(spacing: 30) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 1/255, green: 146/255, blue: 184/255),
                                                                  Color(red: 21/255, green: 93/255, blue: 251/255).opacity(0.7),
                                                                  Color(red: 0/255, green: 117/255, blue: 149/255).opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(red: 51/255, green: 165/255, blue: 202/255), lineWidth: 3)
                                            .overlay {
                                                VStack(alignment: .leading, spacing: 16) {
                                                    Image(.game3)
                                                        .resizable()
                                                        .frame(width: 56, height: 56)
                                                    
                                                    Text("Mines")
                                                        .FontRegular(size: 16)
                                                    
                                                    Text("Avoid mines, collect coins")
                                                        .FontRegular(size: 16, color: Color(red: 213/255, green: 223/255, blue: 247/255))
                                                    
                                                    Button(action: {
                                                        isMines = true
                                                    }) {
                                                        Rectangle()
                                                            .fill(Color(red: 137/255, green: 94/255, blue: 185/255).opacity(0.6))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 14)
                                                                    .stroke(Color(red: 196/255, green: 177/255, blue: 222/255), lineWidth: 3)
                                                                    .overlay {
                                                                        Text("Play")
                                                                            .FontSemiBold(size: 14)
                                                                    }
                                                            }
                                                            .frame(height: 36)
                                                            .cornerRadius(14)
                                                    }
                                                }
                                                .padding(.horizontal, 34)
                                            }
                                    }
                                    .frame(height: 252)
                                    .cornerRadius(24)
                                    .shadow(color: Color(red: 51/255, green: 165/255, blue: 202/255), radius: 15)
                                
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 254/255, green: 154/255, blue: 2/255),
                                                                  Color(red: 241/255, green: 177/255, blue: 0/255).opacity(0.7),
                                                                  Color(red: 225/255, green: 113/255, blue: 0/255).opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(red: 252/255, green: 185/255, blue: 72/255), lineWidth: 3)
                                            .overlay {
                                                VStack(alignment: .leading, spacing: 16) {
                                                    Image(.game4)
                                                        .resizable()
                                                        .frame(width: 56, height: 56)
                                                    
                                                    Text("Scratch Card")
                                                        .FontRegular(size: 16)
                                                    
                                                    Text("Scratch to reveal prizes")
                                                        .FontRegular(size: 16, color: Color(red: 247/255, green: 238/255, blue: 209/255))
                                                    
                                                    Button(action: {
                                                        isScratch = true
                                                    }) {
                                                        Rectangle()
                                                            .fill(Color(red: 137/255, green: 94/255, blue: 185/255).opacity(0.6))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 14)
                                                                    .stroke(Color(red: 196/255, green: 177/255, blue: 222/255), lineWidth: 3)
                                                                    .overlay {
                                                                        Text("Play")
                                                                            .FontSemiBold(size: 14)
                                                                    }
                                                            }
                                                            .frame(height: 36)
                                                            .cornerRadius(14)
                                                    }
                                                }
                                                .padding(.horizontal, 34)
                                            }
                                    }
                                    .frame(height: 252)
                                    .cornerRadius(24)
                                    .shadow(color: Color(red: 252/255, green: 185/255, blue: 72/255), radius: 15)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 254/255, green: 154/255, blue: 2/255),
                                                          Color(red: 241/255, green: 177/255, blue: 0/255).opacity(0.7),
                                                          Color(red: 225/255, green: 113/255, blue: 0/255).opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color(red: 252/255, green: 185/255, blue: 72/255), lineWidth: 3)
                                    .overlay {
                                        VStack(alignment: .leading, spacing: 16) {
                                            HStack {
                                                Image(.daily)
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                
                                                Text("Daily Jackpot")
                                                    .FontRegular(size: 16)
                                                
                                                Spacer()
                                                
                                                Text("Prize Pool")
                                                    .FontRegular(size: 12, color: .white.opacity(0.8))
                                            }
                                            
                                            HStack {
                                                Text("Win up to 10,000 coins!")
                                                    .FontRegular(size: 14, color: .white.opacity(0.9))
                                                
                                                Spacer()
                                                
                                                Text("🎰 10,000")
                                                    .FontRegular(size: 16)
                                            }
                                        }
                                        .padding(.horizontal, 20)
                                    }
                            }
                            .frame(height: 104)
                            .cornerRadius(24)
                            .shadow(color: Color(red: 252/255, green: 185/255, blue: 72/255), radius: 15)
                            .padding(.horizontal)
                            .padding(.top, 30)
                        
                        Color.clear.frame(height: 80)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isMatch) {
            MatchPuzzlesView()
        }
        .fullScreenCover(isPresented: $isMines) {
            MinesView()
        }
        .fullScreenCover(isPresented: $isScratch) {
            ScratchCardsView()
        }
    }
}

#Preview {
    HubMainView(selectedTab: .constant(.Home))
}

