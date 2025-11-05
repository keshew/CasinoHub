import SwiftUI

struct Games: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
    var desc: String
    var min: String
    var maxwin: String
    var gradient: LinearGradient
}

struct HubGamesView: View {
    @StateObject var hubGamesModel =  HubGamesViewModel()
    @State var isMatch = false
    @State var isMines = false
    @State var isScratch = false
    @State var showAlert = false
    
    var arrayGames = [Games(name: "Match-3 Puzzle",
                            imageName: "game2",
                            desc: "Match 3 or more gems in a row to score points and win coins",
                            min: "15",
                            maxwin: "2000",
                            gradient: LinearGradient(colors: [Color(red: 230/255, green: 0/255, blue: 117/255),
                                                              Color(red: 255/255, green: 32/255, blue: 86/255),
                                                              Color(red: 152/255, green: 16/255, blue: 251/255)], startPoint: .topLeading, endPoint: .bottomTrailing)),
                      Games(name: "Mines Game",
                            imageName: "game3",
                            desc: "Click tiles to reveal coins, but avoid the hidden mines",
                            min: "20",
                            maxwin: "3000",
                            gradient: LinearGradient(colors: [Color(red: 21/255, green: 93/255, blue: 251/255),
                                                              Color(red: 0/255, green: 184/255, blue: 219/255),
                                                              Color(red: 1/255, green: 150/255, blue: 138/255)], startPoint: .topLeading, endPoint: .bottomTrailing)),
                      Games(name: "Scratch Card",
                            imageName: "game4",
                            desc: "Scratch the card to reveal hidden prizes and jackpots",
                            min: "10",
                            maxwin: "5000",
                            gradient: LinearGradient(colors: [Color(red: 254/255, green: 105/255, blue: 0/255),
                                                              Color(red: 254/255, green: 154/255, blue: 2/255),
                                                              Color(red: 241/255, green: 177/255, blue: 0/255)], startPoint: .topLeading, endPoint: .bottomTrailing))]
    
    var closedGames = [Games(name: "Classic Fruits",
                            imageName: "slot4",
                            desc: "Traditional slot with cherries, lemons, and bars",
                            min: "10",
                            maxwin: "1 000",
                            gradient: LinearGradient(colors: [Color(red: 230/255, green: 178/255, blue: 0/255),
                                                              Color(red: 255/255, green: 73/255, blue: 32/255),
                                                              Color(red: 152/255, green: 15/255, blue: 250/255)], startPoint: .topLeading, endPoint: .bottomTrailing)),
                      Games(name: "Lepri Rush",
                            imageName: "slot5",
                            desc: "Sparkling gems and precious stones",
                            min: "25",
                            maxwin: "2 500",
                            gradient: LinearGradient(colors: [Color(red: 23/255, green: 148/255, blue: 252/255),
                                                              Color(red: 0/255, green: 219/255, blue: 86/255),
                                                              Color(red: 48/255, green: 0/255, blue: 150/255)], startPoint: .topLeading, endPoint: .bottomTrailing)),
                      Games(name: "Greece Palace",
                            imageName: "slot6",
                            desc: "Kings, queens, and golden crowns",
                            min: "50",
                            maxwin: "5 000",
                            gradient: LinearGradient(colors: [Color(red: 158/255, green: 0/255, blue: 255/255),
                                                              Color(red: 255/255, green: 223/255, blue: 0/255),
                                                              Color(red: 240/255, green: 0/255, blue: 48/255)], startPoint: .topLeading, endPoint: .bottomTrailing))]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOn") ? [Color(red: 240/255, green: 213/255, blue: 222/255).opacity(0.8),
                                                                                 Color(red: 252/255, green: 205/255, blue: 233/255).opacity(0.8),
                                                                                 Color(red: 252/255, green: 248/255, blue: 248/255).opacity(0.8)] : [Color(red: 13/255, green: 18/255, blue: 24/255),
                                                                                                                                                     Color(red: 60/255, green: 15/255, blue: 102/255),
                                                                                                                                                     Color(red: 30/255, green: 26/255, blue: 77/255)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text("Mini Games")
                        .FontRegular(size: 16, color: UserDefaults.standard.bool(forKey: "isOn") ? Color(red: 177/255, green: 75/255, blue: 250/255) : .white)
                        .padding(.top)
                    
                    Text("Choose your favorite game and start winning")
                        .FontRegular(size: 16, color: Color(red: 217/255, green: 179/255, blue: 255/255))
                }
                
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(arrayGames, id: \.id) { item in
                                Rectangle()
                                    .fill(item.gradient)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(red: 137/255, green: 75/255, blue: 52/255), lineWidth: 0)
                                            .overlay {
                                                VStack(spacing: 34) {
                                                    HStack(alignment: .top) {
                                                        Image(item.imageName)
                                                            .resizable()
                                                            .frame(width: 80, height: 80)
                                                        
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            HStack {
                                                                Text(item.name)
                                                                    .FontRegular(size: 16, color: Color(red: 254/255, green: 252/255, blue: 231/255))
                                                                
                                                                Image(.themeYellow)
                                                                    .resizable()
                                                                    .frame(width: 20, height: 20)
                                                            }
                                                            
                                                            Text(item.desc)
                                                                .FontRegular(size: 14, color: Color(red: 255/255, green: 249/255, blue: 194/255).opacity(0.8))
                                                            
                                                            HStack(spacing: 10) {
                                                                Rectangle()
                                                                    .fill(.white.opacity(0.2))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 16)
                                                                            .stroke(.white.opacity(0.3), lineWidth: 3)
                                                                            .overlay {
                                                                                Text("Min:\n\(item.min)")
                                                                                    .FontRegular(size: 14)
                                                                            }
                                                                    }
                                                                    .frame(width: 57, height: 54)
                                                                    .cornerRadius(16)
                                                                
                                                                Rectangle()
                                                                    .fill(.white.opacity(0.2))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 16)
                                                                            .stroke(.white.opacity(0.3), lineWidth: 3)
                                                                            .overlay {
                                                                                Text("Max Win:\n\(item.maxwin)")
                                                                                    .FontRegular(size: 14)
                                                                            }
                                                                    }
                                                                    .frame(width: 96, height: 54)
                                                                    .cornerRadius(16)
                                                            }
                                                            .padding(.top, 10)
                                                            
                                                            
                                                        }
                                                        .padding(.horizontal, 5)
                                                        
                                                        Spacer()
                                                    }
                                                    .padding(.horizontal)
                                                    
                                                    Button(action: {
                                                        switch item.name {
                                                        case "Match-3 Puzzle":
                                                            isMatch = true
                                                        case "Mines Game":
                                                            isMines = true
                                                        case "Scratch Card":
                                                            isScratch = true
                                                        default:
                                                            break
                                                        }
                                                    }) {
                                                        Rectangle()
                                                            .fill(.white.opacity(0.2))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(.white.opacity(0.3), lineWidth: 3)
                                                                    .overlay {
                                                                        HStack {
                                                                            Image(systemName: "star")
                                                                                .foregroundStyle(.white)
                                                                            
                                                                            Text("Play now")
                                                                                .FontSemiBold(size: 14)
                                                                        }
                                                                    }
                                                            }
                                                            .frame(height: 54)
                                                            .cornerRadius(16)
                                                            .padding(.horizontal)
                                                    }
                                                }
                                            }
                                    }
                                    .frame(height: 270)
                                    .cornerRadius(24)
                            }
                            
                            ForEach(closedGames, id: \.id) { item in
                                Rectangle()
                                    .fill(item.gradient)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(red: 137/255, green: 75/255, blue: 52/255), lineWidth: 0)
                                            .overlay {
                                                VStack(spacing: 34) {
                                                    HStack(alignment: .top) {
                                                        Image(item.imageName)
                                                            .resizable()
                                                            .frame(width: 80, height: 80)
                                                            .blur(radius: 10)
                                                        
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            HStack {
                                                                Text(item.name)
                                                                    .FontRegular(size: 16, color: Color(red: 254/255, green: 252/255, blue: 231/255))
                                                                
                                                                Image(.themeYellow)
                                                                    .resizable()
                                                                    .frame(width: 20, height: 20)
                                                            }
                                                            .blur(radius: 5)
                                                            
                                                            Text(item.desc)
                                                                .FontRegular(size: 14, color: Color(red: 255/255, green: 249/255, blue: 194/255).opacity(0.8))
                                                                .blur(radius: 5)
                                                            
                                                            HStack(spacing: 10) {
                                                                Rectangle()
                                                                    .fill(.white.opacity(0.2))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 16)
                                                                            .stroke(.white.opacity(0.3), lineWidth: 3)
                                                                            .overlay {
                                                                                Text("Min:\n\(item.min)")
                                                                                    .FontRegular(size: 14)
                                                                            }
                                                                    }
                                                                    .frame(width: 57, height: 54)
                                                                    .cornerRadius(16)
                                                                
                                                                Rectangle()
                                                                    .fill(.white.opacity(0.2))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 16)
                                                                            .stroke(.white.opacity(0.3), lineWidth: 3)
                                                                            .overlay {
                                                                                Text("Max Win:\n\(item.maxwin)")
                                                                                    .FontRegular(size: 14)
                                                                            }
                                                                    }
                                                                    .frame(width: 96, height: 54)
                                                                    .cornerRadius(16)
                                                            }
                                                            .padding(.top, 10)
                                                            .blur(radius: 5)
                                                            
                                                         
                                                        }
                                                        .padding(.horizontal, 5)
                                                        
                                                        Spacer()
                                                    }
                                                    .padding(.horizontal)
                                                    
                                                    Button(action: {
                                                        showAlert = true
                                                    }) {
                                                        Rectangle()
                                                            .fill(.white.opacity(0.2))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(.white.opacity(0.3), lineWidth: 3)
                                                                    .overlay {
                                                                        HStack {
                                                                            Text("Buy a game")
                                                                                .FontSemiBold(size: 14)
                                                                            
                                                                            Spacer()

                                                                            Text("100 000")
                                                                                .FontHeavy(size: 14)
                                                                            
                                                                            Image("coins")
                                                                                .resizable()
                                                                                .frame(width: 27, height: 27)
                                                                                .foregroundStyle(.white)
                                                                        }
                                                                        .padding(.horizontal)
                                                                    }
                                                            }
                                                            .frame(height: 52)
                                                            .cornerRadius(16)
                                                    }
                                                    .padding(.top)
                                                    .padding(.horizontal)
                                                    .alert("Not enough coin", isPresented: $showAlert) {
                                                        Button("OK") {
                                                            showAlert.toggle()
                                                        }
                                                    }
                                                }
                                            }
                                    }
                                    .frame(height: 240)
                                    .cornerRadius(24)
                            }
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 89/255, green: 22/255, blue: 139/255).opacity(0.4),
                                                              Color(red: 110/255, green: 17/255, blue: 176/255).opacity(0.3),
                                                              Color(red: 49/255, green: 44/255, blue: 132/255).opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color(red: 97/255, green: 47/255, blue: 135/255), lineWidth: 3)
                                        .overlay {
                                            VStack(spacing: 15) {
                                                Image(.themeYellow)
                                                    .resizable()
                                                    .frame(width: 32, height: 32)
                                                
                                                Text("All games are fully playable! More features and bonuses coming soon.")
                                                    .FontRegular(size: 16)
                                                    .multilineTextAlignment(.center)
                                                    .padding(.horizontal)
                                            }
                                        }
                                }
                                .frame(height: 148)
                                .cornerRadius(24)
                            
                            Color.clear.frame(height: 80)
                        }
                        .padding(.horizontal)
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
    HubGamesView()
}

