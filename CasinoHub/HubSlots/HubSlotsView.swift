import SwiftUI

struct HubSlotsView: View {
    @StateObject var hubSlotsModel =  HubSlotsViewModel()
    @State var isFruit = false
    @State var isGem = false
    @State var isRoyal = false
    @State var isMagic = false
    @State var isStars = false
    @State var isDeluxe = false
    
    var arrayGames = [Games(name: "Classic Fruits",
                            imageName: "slot1",
                            desc: "Traditional slot with cherries, lemons, and bars",
                            min: "10",
                            maxwin: "1 000",
                            gradient: LinearGradient(colors: [Color(red: 230/255, green: 0/255, blue: 117/255),
                                                              Color(red: 255/255, green: 32/255, blue: 86/255),
                                                              Color(red: 245/255, green: 73/255, blue: 1/255)], startPoint: .topLeading, endPoint: .bottomTrailing)),
                      Games(name: "Gem Rush",
                            imageName: "slot2",
                            desc: "Sparkling gems and precious stones",
                            min: "25",
                            maxwin: "2 500",
                            gradient: LinearGradient(colors: [Color(red: 0/255, green: 153/255, blue: 102/255),
                                                              Color(red: 0/255, green: 201/255, blue: 80/255),
                                                              Color(red: 1/255, green: 150/255, blue: 138/255)], startPoint: .topLeading, endPoint: .bottomTrailing)),
                      Games(name: "Royal Palace",
                            imageName: "slot3",
                            desc: "Kings, queens, and golden crowns",
                            min: "50",
                            maxwin: "5 000",
                            gradient: LinearGradient(colors: [Color(red: 254/255, green: 105/255, blue: 0/255),
                                                              Color(red: 254/255, green: 154/255, blue: 2/255),
                                                              Color(red: 241/255, green: 177/255, blue: 0/255)], startPoint: .topLeading, endPoint: .bottomTrailing)),
                      Games(name: "Magic Spin",
                            imageName: "slot4",
                            desc: "Enchanted reels with mystical symbols",
                            min: "20",
                            maxwin: "2 000",
                            gradient: LinearGradient(colors: [Color(red: 152/255, green: 16/255, blue: 251/255),
                                                              Color(red: 142/255, green: 81/255, blue: 255/255),
                                                              Color(red: 230/255, green: 0/255, blue: 117/255)], startPoint: .topLeading, endPoint: .bottomTrailing)),
                      Games(name: "Lucky Stars",
                            imageName: "slot5",
                            desc: "Shooting stars and cosmic wins",
                            min: "30",
                            maxwin: "3 000",
                            gradient: LinearGradient(colors: [Color(red: 21/255, green: 93/255, blue: 251/255),
                                                              Color(red: 97/255, green: 95/255, blue: 255/255),
                                                              Color(red: 152/255, green: 16/255, blue: 251/255)], startPoint: .topLeading, endPoint: .bottomTrailing)),
                      Games(name: "Diamond Deluxe",
                            imageName: "slot6",
                            desc: "Premium diamonds and luxury symbols",
                            min: "100",
                            maxwin: "10 000",
                            gradient: LinearGradient(colors: [Color(red: 0/255, green: 184/255, blue: 219/255),
                                                              Color(red: 0/255, green: 166/255, blue: 244/255),
                                                              Color(red: 21/255, green: 93/255, blue: 251/255)], startPoint: .topLeading, endPoint: .bottomTrailing))]
    
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
                                                            
                                                            Button(action: {
                                                                switch item.name {
                                                                case "Classic Fruits":
                                                                    isFruit = true
                                                                case "Gem Rush":
                                                                    isGem = true
                                                                case "Royal Palace":
                                                                    isRoyal = true
                                                                case "Magic Spin":
                                                                    isMagic = true
                                                                case "Lucky Stars":
                                                                    isStars = true
                                                                case "Diamond Deluxe":
                                                                    isDeluxe = true
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
                                                                                    Image("daily")
                                                                                        .resizable()
                                                                                        .frame(width: 16, height: 16)
                                                                                        .foregroundStyle(.white)
                                                                                    
                                                                                    Text("Play now")
                                                                                        .FontSemiBold(size: 14)
                                                                                }
                                                                            }
                                                                    }
                                                                    .frame(height: 36)
                                                                    .cornerRadius(16)
                                                            }
                                                            .padding(.top)
                                                        }
                                                        .padding(.horizontal, 5)
                                                        
                                                        Spacer()
                                                    }
                                                    .padding(.horizontal)
                                                    
                                                    
                                                }
                                            }
                                    }
                                    .frame(height: 240)
                                    .cornerRadius(24)
                            }
                            
                            Color.clear.frame(height: 80)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isFruit) {
            ClassicFruitView()
        }
        .fullScreenCover(isPresented: $isGem) {
            GemRushView()
        }
        .fullScreenCover(isPresented: $isRoyal) {
            RoyalPalaceView()
        }
        .fullScreenCover(isPresented: $isMagic) {
            MagicSpinView()
        }
        .fullScreenCover(isPresented: $isStars) {
            LuckyStarsView()
        }
        .fullScreenCover(isPresented: $isDeluxe) {
            DiamondDeluxeView()
        }
    }
}

#Preview {
    HubSlotsView()
}

