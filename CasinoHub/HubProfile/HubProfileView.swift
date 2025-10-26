import SwiftUI

struct HubProfileView: View {
    @StateObject var hubProfileModel =  HubProfileViewModel()
    @State private var activities: [GameActivity] = []
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
                Text("Profile")
                    .FontRegular(size: 16)
                    .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 89/255, green: 22/255, blue: 139/255),
                                                          Color(red: 49/255, green: 44/255, blue: 132/255),
                                                          Color(red: 89/255, green: 22/255, blue: 139/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 102/255, green: 50/255, blue: 147/255), lineWidth: 3)
                                    .overlay {
                                        VStack(spacing: 20) {
                                            ZStack(alignment: .bottomTrailing) {
                                                Circle()
                                                    .fill(LinearGradient(colors: [Color(red: 78/255, green: 57/255, blue: 246/255).opacity(0.7),
                                                                                  Color(red: 152/255, green: 16/255, blue: 251/255).opacity(0.7),
                                                                                  Color(red: 230/255, green: 0/255, blue: 117/255).opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 84)
                                                            .stroke(Color(red: 146/255, green: 74/255, blue: 209/255), lineWidth: 7)
                                                            .overlay {
                                                                Text("P")
                                                                    .FontRegular(size: 36)
                                                            }
                                                    }
                                                    .frame(height: 103)
                                                    .cornerRadius(84)
                                                    .padding(.horizontal)
                                                
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [Color(red: 253/255, green: 199/255, blue: 2/255),
                                                                                  Color(red: 254/255, green: 154/255, blue: 2/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(.black, lineWidth: 4)
                                                            .overlay {
                                                                Text("\(level)")
                                                                    .FontRegular(size: 16, color: .black)
                                                            }
                                                    }
                                                    .frame(width: 46, height: 46)
                                                    .cornerRadius(16)
                                                    .padding(.horizontal)
                                            }
                                            
                                            Text("Player")
                                                .FontRegular(size: 14)
                                                .multilineTextAlignment(.center)
                                            
                                            Rectangle()
                                                .fill(Color(red: 194/255, green: 122/255, blue: 255/255).opacity(0.2))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(red: 149/255, green: 61/255, blue: 192/255), lineWidth: 2)
                                                        .overlay {
                                                            HStack {
                                                                Image(.menu3)
                                                                    .resizable()
                                                                    .frame(width: 16, height: 16)
                                                                
                                                                Text("Level \(level) Player")
                                                                    .FontRegular(size: 16, color: Color(red: 232/255, green: 212/255, blue: 255/255))
                                                            }
                                                        }
                                                }
                                                .frame(width: 155, height: 40)
                                                .cornerRadius(20)
                                            
                                            VStack(spacing: 8) {
                                                HStack {
                                                    Text("Progress to Level \(level + 1)")
                                                        .FontRegular(size: 14, color: Color(red: 217/255, green: 179/255, blue: 255/255))
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(progress) / \(pointsPerLevel) XP")
                                                        .FontRegular(size: 14, color: Color(red: 217/255, green: 179/255, blue: 255/255))
                                                }
                                                .padding(.horizontal, 20)
                                                
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
                                                .frame(maxWidth: 300)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .frame(height: 320)
                            .cornerRadius(16)
                            .padding(.horizontal)
                        
                        VStack(spacing: 20) {
                            HStack(spacing: 30) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 116/255, green: 62/255, blue: 14/255).opacity(0.4),
                                                                  Color(red: 123/255, green: 51/255, blue: 14/255).opacity(0.3),
                                                                  Color(red: 137/255, green: 75/255, blue: 4/255).opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(red: 137/255, green: 75/255, blue: 52/255), lineWidth: 3)
                                            .overlay {
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 10) {
                                                        Image(.profile1)
                                                            .resizable()
                                                            .frame(width: 56, height: 56)
                                                        
                                                        Text("Total Coins")
                                                            .FontRegular(size: 14, color: Color(red: 249/255, green: 224/255, blue: 86/255))
                                                        
                                                        Text("\(UserDefaultsManager.shared.coins)")
                                                            .FontRegular(size: 16)
                                                    }
                                                    .padding(.horizontal, 34)
                                                    
                                                    Spacer()
                                                }
                                            }
                                    }
                                    .frame(height: 172)
                                    .cornerRadius(24)
                                
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 89/255, green: 22/255, blue: 139/255).opacity(0.4),
                                                                  Color(red: 77/255, green: 24/255, blue: 154/255).opacity(0.3),
                                                                  Color(red: 110/255, green: 17/255, blue: 176/255).opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(red: 112/255, green: 34/255, blue: 164/255), lineWidth: 3)
                                            .overlay {
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 10) {
                                                        Image(.profile2)
                                                            .resizable()
                                                            .frame(width: 56, height: 56)
                                                        
                                                        Text("Total Wins")
                                                            .FontRegular(size: 14, color: Color(red: 188/255, green: 147/255, blue: 226/255))
                                                        
                                                        Text("\(UserDefaultsManager.shared.totalWin)")
                                                            .FontRegular(size: 16)
                                                    }
                                                    .padding(.horizontal, 34)
                                                    
                                                    Spacer()
                                                }
                                            }
                                    }
                                    .frame(height: 172)
                                    .cornerRadius(24)
                            }
                            
                            HStack(spacing: 30) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 134/255, green: 17/255, blue: 67/255).opacity(0.4),
                                                                  Color(red: 139/255, green: 9/255, blue: 54/255).opacity(0.3),
                                                                  Color(red: 163/255, green: 0/255, blue: 76/255).opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(red: 125/255, green: 26/255, blue: 101/255), lineWidth: 3)
                                            .overlay {
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 10) {
                                                        Image(.profile4)
                                                            .resizable()
                                                            .frame(width: 56, height: 56)
                                                        
                                                        Text("Biggest Win")
                                                            .FontRegular(size: 14, color: Color(red: 253/255, green: 165/255, blue: 213/255).opacity(0.8))
                                                        
                                                        Text("\(UserDefaultsManager.shared.maxWin)")
                                                            .FontRegular(size: 16)
                                                    }
                                                    .padding(.horizontal, 34)
                                                    
                                                    Spacer()
                                                }
                                            }
                                    }
                                    .frame(height: 172)
                                    .cornerRadius(24)
                                
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 14/255, green: 84/255, blue: 43/255).opacity(0.4),
                                                                  Color(red: 3/255, green: 79/255, blue: 59/255).opacity(0.3),
                                                                  Color(red: 1/255, green: 102/255, blue: 48/255).opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(red: 20/255, green: 90/255, blue: 72/255), lineWidth: 3)
                                            .overlay {
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 10) {
                                                        Image(.profile3)
                                                            .resizable()
                                                            .frame(width: 56, height: 56)
                                                        
                                                        Text("Win Rate")
                                                            .FontRegular(size: 14, color: Color(red: 102/255, green: 191/255, blue: 143/255))
                                                        
                                                        let totalGames = max(1, UserDefaultsManager.shared.totalGames) 
                                                          let winRate = Double(UserDefaultsManager.shared.totalWin) / (Double(totalGames) * 100)
                                                          Text(String(format: "%.1f%%", winRate))
                                                              .FontRegular(size: 16)
                                                    }
                                                    .padding(.horizontal, 34)
                                                    
                                                    Spacer()
                                                }
                                            }
                                    }
                                    .frame(height: 172)
                                    .cornerRadius(24)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        Rectangle()
                            .fill(.black.opacity(0.2))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 67/255, green: 31/255, blue: 94/255).opacity(0.8), lineWidth: 3)
                                    .overlay {
                                        VStack(spacing: 16) {
                                            HStack {
                                                Image(.recent)
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                
                                                Text("Recent Activity")
                                                    .FontRegular(size: 16)
                                                
                                                Spacer()
                                            }
                                            .padding(.leading)
                                            
                                            VStack(spacing: 20) {
                                                if activities.count == 0 {
                                                    ForEach(0..<3, id: \.self) { _ in
                                                        Rectangle()
                                                            .fill(Color.black.opacity(0.1))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(Color(red: 82/255, green: 61/255, blue: 98/255), lineWidth: 2)
                                                                    .overlay {
                                                                        HStack {
                                                                            Text("No recent activity yet")
                                                                                .FontRegular(size: 16)
                                                                            Spacer()
                                                                        }
                                                                        .padding(.horizontal)
                                                                    }
                                                            }
                                                            .frame(height: 56)
                                                            .cornerRadius(16)
                                                            .padding(.horizontal)
                                                    }
                                                } else {
                                                    let paddedActivities = activities + Array(repeating: GameActivity(gameName: "", amount: 0), count: max(0, 3 - activities.count))
                                                    ForEach(0..<3, id: \.self) { index in
                                                        let activity = paddedActivities[index]
                                                        if activity.gameName.isEmpty {
                                                            Rectangle()
                                                                .fill(Color.black.opacity(0.1))
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 16)
                                                                        .stroke(Color(red: 82/255, green: 61/255, blue: 98/255), lineWidth: 2)
                                                                        .overlay {
                                                                            HStack {
                                                                                Text("No recent activity yet")
                                                                                    .FontRegular(size: 16)
                                                                                Spacer()
                                                                            }
                                                                            .padding(.horizontal)
                                                                        }
                                                                }
                                                                .frame(height: 56)
                                                                .cornerRadius(16)
                                                                .padding(.horizontal)
                                                        } else {
                                                            Rectangle()
                                                                .fill(Color.black.opacity(0.1))
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 16)
                                                                        .stroke(Color(red: 82/255, green: 61/255, blue: 98/255), lineWidth: 2)
                                                                        .overlay {
                                                                            HStack {
                                                                                HStack {
                                                                                    Text(activity.gameName)
                                                                                        .FontRegular(size: 16)
                                                                                    Spacer()
                                                                                    Text(String(format: "%+d", activity.amount))
                                                                                        .FontRegular(size: 16, color: activity.amount >= 0
                                                                                                     ? Color(red: 4/255, green: 223/255, blue: 114/255)
                                                                                                     : .red)
                                                                                }
                                                                                Spacer()
                                                                            }
                                                                            .padding(.horizontal)
                                                                        }
                                                                }
                                                                .frame(height: 56)
                                                                .cornerRadius(16)
                                                                .padding(.horizontal)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .frame(height: 294)
                            .cornerRadius(16)
                            .padding(.horizontal)
                        
                        Color.clear.frame(height: 80)
                    }
                }
            }
        }
        .onAppear {
            activities = UserDefaultsManager.shared.lastActivities
            print(UserDefaultsManager.shared.lastActivities)
        }
    }
}

#Preview {
    HubProfileView()
}

