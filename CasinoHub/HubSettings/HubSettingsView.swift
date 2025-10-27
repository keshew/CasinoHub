import SwiftUI

struct HubSettingsView: View {
    @StateObject var hubSettingsModel =  HubSettingsViewModel()
    @State private var showResetAlert = false
    @State var isOn = UserDefaults.standard.bool(forKey: "isOn")
    
    var body: some View {
        ZStack {
            LinearGradient(colors: isOn ? [Color(red: 240/255, green: 213/255, blue: 222/255).opacity(0.8),
                                           Color(red: 252/255, green: 205/255, blue: 233/255).opacity(0.8),
                                           Color(red: 252/255, green: 248/255, blue: 248/255).opacity(0.8)] : [Color(red: 13/255, green: 18/255, blue: 24/255),
                                                                                               Color(red: 60/255, green: 15/255, blue: 102/255),
                                                                                               Color(red: 30/255, green: 26/255, blue: 77/255)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack(spacing: 32) {
                Text("Settings")
                    .FontRegular(size: 16, color: isOn ? Color(red: 177/255, green: 75/255, blue: 250/255) : .white)
                    .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
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
                                                Image(.theme1)
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                
                                                Text("Theme Selector")
                                                    .FontRegular(size: 16)
                                                
                                                Image(.theme2)
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                            }
                                            
                                            Rectangle()
                                                .fill(LinearGradient(colors: [Color(red: 78/255, green: 57/255, blue: 246/255).opacity(0.7),
                                                                              Color(red: 152/255, green: 16/255, blue: 251/255).opacity(0.7),
                                                                              Color(red: 230/255, green: 0/255, blue: 117/255).opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 24)
                                                        .stroke(Color(red: 174/255, green: 70/255, blue: 253/255), lineWidth: 2)
                                                        .overlay {
                                                            HStack {
                                                                Image(isOn ? "morning" : "themeDark")
                                                                    .resizable()
                                                                    .frame(width: 61, height: 64)
                                                                
                                                                Spacer()
                                                                
                                                                VStack(alignment: .leading) {
                                                                    Text(isOn ? "☀️ Luxury Morning" : "🌙 Neon Night")
                                                                        .FontRegular(size: 16)
                                                                    
                                                                    Text(isOn ? "Light theme active" : "Dark theme active")
                                                                        .FontRegular(size: 14, color: Color(red: 232/255, green: 212/255, blue: 255/255))
                                                                }
                                                                
                                                                Spacer()
                                                                
                                                                Button(action: {
                                                                    withAnimation {
                                                                        isOn.toggle()
                                                                        UserDefaults.standard.set(isOn, forKey: "isOn")
                                                                        NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
                                                                    }
                                                                }) {
                                                                    Rectangle()
                                                                        .fill(Color(red: 193/255, green: 76/255, blue: 228/255))
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 20)
                                                                                .stroke(Color(red: 211/255, green: 130/255, blue: 237/255), lineWidth: 3)
                                                                                .overlay {
                                                                                    Text("Tap to switch")
                                                                                        .FontRegular(size: 14)
                                                                                }
                                                                        }
                                                                        .frame(width: 100, height: 58)
                                                                        .cornerRadius(20)
                                                                }
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                }
                                                .frame(height: 164)
                                                .cornerRadius(24)
                                                .padding(.horizontal)
                                            
                                            Text(isOn ? "✨ Enjoy the elegant luxury morning\nambiance" : "✨ Experience the vibrant neon night\natmosphere")
                                                .FontRegular(size: 14, color: Color(red: 232/255, green: 212/255, blue: 255/255))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .frame(height: 320)
                            .cornerRadius(16)
                            .padding(.horizontal)
                        
                        Rectangle()
                            .fill(.black.opacity(0.2))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 102/255, green: 50/255, blue: 147/255), lineWidth: 3)
                                    .overlay {
                                        VStack(spacing: 12) {
                                            HStack {
                                                Image(.theme1)
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                
                                                Text("Audio & Notifications")
                                                    .FontRegular(size: 16, color: isOn ? Color(red: 177/255, green: 75/255, blue: 250/255) : .white)
                                                
                                                Spacer()
                                            }
                                            .padding(.leading)
                                            
                                            Rectangle()
                                                .fill(.black.opacity(0.1))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(red: 63/255, green: 59/255, blue: 91/255), lineWidth: 2)
                                                        .overlay {
                                                            VStack {
                                                                HStack {
                                                                    Image(.settings2)
                                                                        .resizable()
                                                                        .frame(width: 48, height: 48)
                                                                    
                                                                    VStack(alignment: .leading) {
                                                                        Text("Notifications")
                                                                            .FontRegular(size: 16)
                                                                        
                                                                        Text("Daily rewards & updates")
                                                                            .FontRegular(size: 16, color: isOn ? Color(red: 177/255, green: 75/255, blue: 250/255) : Color(red: 153/255, green: 161/255, blue: 175/255))
                                                                    }
                                                                    
                                                                    Spacer()
                                                                    
                                                                    Toggle("", isOn: $hubSettingsModel.isOn)
                                                                        .toggleStyle(CustomToggleStyle())
                                                                        .frame(width: 48)
                                                                }
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                }
                                                .frame(height: 82)
                                                .cornerRadius(16)
                                                .padding(.horizontal)
                                            
                                            Rectangle()
                                                .fill(.black.opacity(0.1))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(red: 63/255, green: 59/255, blue: 91/255), lineWidth: 2)
                                                        .overlay {
                                                            VStack {
                                                                HStack {
                                                                    Image(.settings3)
                                                                        .resizable()
                                                                        .frame(width: 48, height: 48)
                                                                    
                                                                    VStack(alignment: .leading) {
                                                                        Text("Haptic Feedback")
                                                                            .FontRegular(size: 16)
                                                                        
                                                                        Text("Vibration on actions")
                                                                            .FontRegular(size: 16, color: isOn ? Color(red: 177/255, green: 75/255, blue: 250/255) : Color(red: 153/255, green: 161/255, blue: 175/255))
                                                                    }
                                                                    
                                                                    Spacer()
                                                                    
                                                                    Toggle("", isOn: $hubSettingsModel.isVib)
                                                                        .toggleStyle(CustomToggleStyle())
                                                                        .frame(width: 48)
                                                                }
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                }
                                                .frame(height: 82)
                                                .cornerRadius(16)
                                                .padding(.horizontal)
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .frame(height: 240)
                            .cornerRadius(16)
                            .padding(.horizontal)
                        
                        Rectangle()
                            .fill(Color(red: 251/255, green: 44/255, blue: 55/255).opacity(0.3))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 124/255, green: 26/255, blue: 63/255), lineWidth: 3)
                                    .overlay {
                                        VStack(spacing: 22) {
                                            HStack {
                                                Image(.deleteRed)
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                
                                                Text("Account Actions")
                                                    .FontRegular(size: 16)
                                                
                                                Spacer()
                                            }
                                            .padding(.leading)
                                            
                                            Button(action: {
                                                showResetAlert = true
                                            }) {
                                                Rectangle()
                                                    .fill(Color(red: 229/255, green: 13/255, blue: 21/255))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 243/255, green: 49/255, blue: 57/255), lineWidth: 2)
                                                            .overlay {
                                                                VStack {
                                                                    HStack {
                                                                        Image(.delete)
                                                                            .resizable()
                                                                            .frame(width: 16, height: 16)
                                                                        
                                                                        Text("Reset Progress")
                                                                            .FontSemiBold(size: 14)
                                                                    }
                                                                }
                                                                .padding(.horizontal)
                                                            }
                                                    }
                                                    .frame(height: 52)
                                                    .cornerRadius(16)
                                                    .padding(.horizontal)
                                            }
                                            .alert("Are you sure you want to delete all progress?", isPresented: $showResetAlert) {
                                                Button("Cancel", role: .cancel) {}
                                                Button("Delete", role: .destructive) {
                                                    UserDefaultsManager.shared.resetAll()
                                                }
                                            }
                                            
                                            Text("This will reset all your progress and coins")
                                                .FontRegular(size: 12, color: isOn ? Color(red: 177/255, green: 75/255, blue: 250/255) :  Color(red: 255/255, green: 201/255, blue: 201/255).opacity(0.8))
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .frame(height: 176)
                            .cornerRadius(16)
                            .padding(.horizontal)
                        
                        Color.clear.frame(height: 80)
                    }
                }
            }
        }
    }
}

#Preview {
    HubSettingsView()
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 109/255, green: 40/255, blue: 217/255) : Color(red: 75/255, green: 85/255, blue: 99/255))
                .frame(width: 44, height: 24)
                .overlay(
                    Circle()
                        .fill(.white)
                        .frame(width: 20, height: 20)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
