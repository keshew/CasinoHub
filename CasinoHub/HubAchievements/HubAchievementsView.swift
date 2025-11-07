import SwiftUI

struct Achiev: Identifiable, Codable {
    var id = UUID()
    var name: String
    var desc: String
    var goal: Int
    var currentGoal: Int
    var isUnlocked: Bool {
        currentGoal >= goal
    }
}

struct HubAchievementsView: View {
    @State var achiev = [Achiev(name: "First Spin", desc: "Spin your first slot machine", goal: 1, currentGoal: UserDefaults.standard.integer(forKey: "firstGame")),
                  Achiev(name: "Lucky Winner", desc: "Win 1000 coins in a single spin", goal: 1000, currentGoal: 0),
                  Achiev(name: "Speed Player", desc: "Complete 50 spins in one session", goal: 50, currentGoal: 0),
                  Achiev(name: "High Roller", desc: "Win 100 coins in a single spin", goal: 100, currentGoal: 0),
                  Achiev(name: "Jackpot Hunter", desc: "Win 10,000 coins in total", goal: 10000, currentGoal: 0),
                  Achiev(name: "Dedicated Player", desc: "Log in for 7 consecutive days", goal: 7, currentGoal: 0)]
    
    func loadAchievementsProgress() -> [Achiev] {
        var achiev = [
            Achiev(name: "First Spin", desc: "Spin your first slot machine", goal: 1, currentGoal: UserDefaults.standard.integer(forKey: "firstGame")),
            Achiev(name: "Lucky Winner", desc: "Win 1000 coins in a single spin", goal: 1000, currentGoal: 0),
            Achiev(name: "Speed Player", desc: "Complete 50 spins in one session", goal: 50, currentGoal: 0),
            Achiev(name: "High Roller", desc: "Win 100 coins in a single spin", goal: 100, currentGoal: 0),
            Achiev(name: "Jackpot Hunter", desc: "Win 10,000 coins in total", goal: 10000, currentGoal: 0),
            Achiev(name: "Dedicated Player", desc: "Log in for 7 consecutive days", goal: 7, currentGoal: 0)
        ]

        let activities = UserDefaultsManager.shared.lastActivities

        if let maxWin = activities.lazy.filter({ $0.amount > 0 }).map({ $0.amount }).max() {
            achiev[1].currentGoal = maxWin
        }

        achiev[2].currentGoal = UserDefaultsManager.shared.totalGames

        if let maxWin = activities.lazy.filter({ $0.amount > 0 }).map({ $0.amount }).max() {
            achiev[3].currentGoal = maxWin
        }

        let totalWin = activities.filter { $0.amount > 0 }.reduce(0) { $0 + $1.amount }
        achiev[4].currentGoal = totalWin

        achiev[5].currentGoal = 0

        return achiev
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOn") ? [Color(red: 240/255, green: 213/255, blue: 222/255).opacity(0.8),
                                                                                 Color(red: 252/255, green: 205/255, blue: 233/255).opacity(0.8),
                                                                                 Color(red: 252/255, green: 248/255, blue: 248/255).opacity(0.8)] : [Color(red: 13/255, green: 18/255, blue: 24/255),
                                                                                                                                                     Color(red: 60/255, green: 15/255, blue: 102/255),
                                                                                                                                                     Color(red: 30/255, green: 26/255, blue: 77/255)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack(spacing: 32) {
                Text("Achievements")
                    .FontRegular(size: 16, color: UserDefaults.standard.bool(forKey: "isOn") ? Color(red: 177/255, green: 75/255, blue: 250/255) : .white)
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
                                            let completedCount = loadAchievementsProgress().filter { $0.isUnlocked }.count
                                            
                                            Image(.achev)
                                                .resizable()
                                                .frame(width: 48, height: 48)
                                            
                                            Text("Achievements Unlocked")
                                                .FontRegular(size: 16, color: Color(red: 232/255, green: 212/255, blue: 255/255))
                                            
                                            HStack(spacing: 5) {
                                                Text("\(completedCount)")
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
                                ForEach(achiev, id: \.id) { index in
                                    if index.isUnlocked {
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
                                                                    Text(index.name)
                                                                        .FontRegular(size: 16, color: Color(red: 254/255, green: 252/255, blue: 231/255))
                                                                    
                                                                    Spacer()
                                                                    
                                                                    Image(.themeYellow)
                                                                        .resizable()
                                                                        .frame(width: 20, height: 20)
                                                                }
                                                                
                                                                Text(index.desc)
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
                                                                    Text(index.name)
                                                                        .FontRegular(size: 16, color: Color(red: 254/255, green: 252/255, blue: 231/255))
                                                                 
                                                                    Spacer()
                                                                    
                                                                }
                                                                
                                                                Text(index.desc)
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
        .onAppear() {
            achiev = loadAchievementsProgress()
        }
    }
}

#Preview {
    HubAchievementsView()
}

