import SwiftUI

struct HubAchievementsView: View {
    @StateObject var hubAchievementsModel =  HubAchievementsViewModel()

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 13/255, green: 18/255, blue: 24/255),
                                    Color(red: 60/255, green: 15/255, blue: 102/255),
                                    Color(red: 30/255, green: 26/255, blue: 77/255)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack(spacing: 32) {
                Text("Achievements")
                    .FontRegular(size: 16)
                    .padding(.top)
                
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 89/255, green: 22/255, blue: 139/255),
                                                          Color(red: 49/255, green: 44/255, blue: 132/255),
                                                          Color(red: 89/255, green: 22/255, blue: 139/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 102/255, green: 50/255, blue: 147/255), lineWidth: 3)
                                    .overlay {
                                        VStack(spacing: 20) {
                                            Image(.achev)
                                                .resizable()
                                                .frame(width: 48, height: 48)
                                            
                                            Text("Achievements Unlocked")
                                                .FontRegular(size: 16, color: Color(red: 232/255, green: 212/255, blue: 255/255))
                                            
                                            HStack(spacing: 5) {
                                                Text("3")
                                                    .FontRegular(size: 36)
                                                
                                                Text("/6")
                                                    .FontRegular(size: 24, color: Color(red: 232/255, green: 212/255, blue: 255/255))
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .frame(height: 197)
                            .cornerRadius(16)
                            .padding(.horizontal)
                        
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 16) {
                                ForEach(0..<3, id: \.self) { index in
                                    if 0 == index {
                                        Rectangle()
                                            .fill(LinearGradient(colors: [Color(red: 116/255, green: 62/255, blue: 14/255).opacity(0.4),
                                                                          Color(red: 123/255, green: 51/255, blue: 14/255).opacity(0.3),
                                                                          Color(red: 137/255, green: 75/255, blue: 4/255).opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 24)
                                                    .stroke(Color(red: 137/255, green: 75/255, blue: 52/255), lineWidth: 3)
                                                    .overlay {
                                                        HStack(alignment: .top) {
                                                            Image(.profile1)
                                                                .resizable()
                                                                .frame(width: 80, height: 80)
                                                            
                                                            VStack(alignment: .leading, spacing: 10) {
                                                                HStack {
                                                                    Text("First Spin")
                                                                        .FontRegular(size: 16, color: Color(red: 254/255, green: 252/255, blue: 231/255))
                                                                    
                                                                    Spacer()
                                                                    
                                                                    Image(.themeYellow)
                                                                        .resizable()
                                                                        .frame(width: 20, height: 20)
                                                                }
                                                                
                                                                Text("Spin your first slot machine")
                                                                    .FontRegular(size: 14, color: Color(red: 255/255, green: 249/255, blue: 194/255).opacity(0.8))
                                                                
                                                                HStack(spacing: 10) {
                                                                    Rectangle()
                                                                        .fill(Color(red: 4/255, green: 223/255, blue: 114/255).opacity(0.2))
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 16)
                                                                                .stroke(Color(red: 4/255, green: 223/255, blue: 114/255).opacity(0.3), lineWidth: 3)
                                                                                .overlay {
                                                                                    HStack {
                                                                                        Image(.starGreen)
                                                                                            .resizable()
                                                                                            .frame(width: 16, height: 16)
                                                                                        
                                                                                        Text("Unlocked")
                                                                                            .FontRegular(size: 14, color: Color(red: 220/255, green: 252/255, blue: 231/255))
                                                                                    }
                                                                                }
                                                                        }
                                                                        .frame(width: 110, height: 34)
                                                                        .cornerRadius(16)
                                                                    
                                                                    HStack {
                                                                        Image(.coins)
                                                                            .resizable()
                                                                            .frame(width: 27, height: 27)
                                                                        
                                                                        Text("100")
                                                                            .FontRegular(size: 14, color: Color(red: 255/255, green: 240/255, blue: 133/255))
                                                                    }
                                                                }
                                                                .padding(.top, 5)
                                                            }
                                                            .padding(.horizontal, 5)
                                                            
                                                            Spacer()
                                                        }
                                                        .padding(.horizontal)
                                                    }
                                            }
                                            .frame(height: 152)
                                            .cornerRadius(24)
                                    } else {
                                        Rectangle()
                                            .fill(LinearGradient(colors: [Color(red: 22/255, green: 26/255, blue: 40/255).opacity(0.6),
                                                                          Color(red: 30/255, green: 41/255, blue: 57/255).opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 24)
                                                    .stroke(Color(red: 56/255, green: 15/255, blue: 98/255), lineWidth: 4)
                                                    .overlay {
                                                        HStack(alignment: .top) {
                                                            Image(.achievLocked)
                                                                .resizable()
                                                                .frame(width: 80, height: 80)
                                                            
                                                            VStack(alignment: .leading, spacing: 10) {
                                                                HStack {
                                                                    Text("First Spin")
                                                                        .FontRegular(size: 16, color: Color(red: 254/255, green: 252/255, blue: 231/255))
                                                                 
                                                                    Spacer()
                                                                    
                                                                }
                                                                
                                                                Text("Spin your first slot machine")
                                                                    .FontRegular(size: 14, color: Color(red: 255/255, green: 249/255, blue: 194/255).opacity(0.8))
                                                                
                                                                HStack(spacing: 20) {
                                                                    Rectangle()
                                                                        .fill(Color(red: 54/255, green: 65/255, blue: 83/255).opacity(0.23))
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 16)
                                                                                .stroke(Color(red: 73/255, green: 85/255, blue: 101/255).opacity(0.3), lineWidth: 3)
                                                                                .overlay {
                                                                                    HStack {
                                                                                        Image(.locked)
                                                                                            .resizable()
                                                                                            .frame(width: 16, height: 16)
                                                                                        
                                                                                        Text("Unlocked")
                                                                                            .FontRegular(size: 14, color: Color(red: 153/255, green: 161/255, blue: 175/255))
                                                                                    }
                                                                                }
                                                                        }
                                                                        .frame(width: 110, height: 34)
                                                                        .cornerRadius(16)
                                                                    
                                                                    HStack {
                                                                        Image(.coins)
                                                                            .resizable()
                                                                            .frame(width: 27, height: 27)
                                                                        
                                                                        Text("100")
                                                                            .FontRegular(size: 14, color: Color(red: 255/255, green: 240/255, blue: 133/255))
                                                                    }
                                                                }
                                                                .padding(.top, 5)
                                                            }
                                                            .padding(.horizontal, 5)
                                                            
                                                            Spacer()
                                                        }
                                                        .padding(.horizontal)
                                                    }
                                            }
                                            .frame(height: 152)
                                            .cornerRadius(24)
                                    }
                                }
                                
                                Color.clear.frame(height: 80)
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HubAchievementsView()
}

