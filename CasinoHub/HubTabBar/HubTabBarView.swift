import SwiftUI

struct HubTabBarView: View {
    @StateObject var hubTabBarModel =  HubTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Home {
                    HubMainView(selectedTab: $selectedTab)
                } else if selectedTab == .Slots {
                    HubSlotsView()
                } else if selectedTab == .Games {
                    HubGamesView()
                } else if selectedTab == .Awards {
                    HubAchievementsView()
                } else if selectedTab == .Profile {
                    HubProfileView()
                } else if selectedTab == .Settings {
                    HubSettingsView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HubTabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    @State private var isOns: Bool = UserDefaults.standard.bool(forKey: "isOn")
    
    enum TabType: Int {
        case Home
        case Slots
        case Games
        case Awards
        case Profile
        case Settings
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(LinearGradient(colors: isOns ? [.white.opacity(0.95),
                                                              Color(red: 250/255, green: 244/255, blue: 255/255).opacity(0.9),
                                                              Color(red: 253/255, green: 242/255, blue: 249/255).opacity(0.85)] : [Color(red: 13/255, green: 18/255, blue: 24/255).opacity(0.98),
                                                                                                                               Color(red: 22/255, green: 26/255, blue: 40/255).opacity(0.95),
                                                                                                                               Color(red: 22/255, green: 26/255, blue: 40/255).opacity(0.9)], startPoint: .top, endPoint: .bottom))
                        .frame(height: 110)
                        .edgesIgnoringSafeArea(.bottom)
                    
                    Rectangle()
                        .fill(isOns ? Color(red: 211/255, green: 190/255, blue: 221/255) : Color(red: 64/255, green: 37/255, blue: 105/255))
                        .frame(height: 3)
                }
                .offset(y: 35)
            }
            
            HStack(spacing: 30) {
                TabBarItem(imageName: "tab1", tab: .Home, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .Slots, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Games, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab4", tab: .Awards, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab5", tab: .Profile, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab6", tab: .Settings, selectedTab: $selectedTab)
            }
            .padding(.top, 10)
            .frame(height: 60)
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("UserResourcesUpdated"),
                                                   object: nil,
                                                   queue: .main) { _ in
                self.isOns = UserDefaults.standard.bool(forKey: "isOn")
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self,
                                                      name: Notification.Name("UserResourcesUpdated"),
                                                      object: nil)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    @State private var isOns: Bool = UserDefaults.standard.bool(forKey: "isOn")
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = tab
            }
        }) {
            VStack(spacing: 12) {
                VStack {
                    Image(isOns ? (selectedTab == tab ? "\(imageName)DarkPicked" : "\(imageName)Dark") : (selectedTab == tab ? "\(imageName)Picked" : imageName))
                        .resizable()
                        .frame(width: 24, height: 24)
                        .shadow(color: isOns ? Color(red: 194/255, green: 122/255, blue: 255/255) : Color(red: 253/255, green: 199/255, blue: 2/255), radius: selectedTab == tab ? 10 : 0)
                    
                    Text("\(tab)")
                        .FontRegular(
                            size: 12,
                            color: isOns ? (selectedTab == tab
                                            ? Color(red: 130/255, green: 0/255, blue: 219/255) : Color(red: 194/255, green: 122/255, blue: 255/255)) : (selectedTab == tab
                            ? Color(red: 253/255, green: 199/255, blue: 2/255) : Color(red: 153/255, green: 161/255, blue: 175/255)))
                }
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("UserResourcesUpdated"),
                                                   object: nil,
                                                   queue: .main) { _ in
                self.isOns = UserDefaults.standard.bool(forKey: "isOn")
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self,
                                                      name: Notification.Name("UserResourcesUpdated"),
                                                      object: nil)
        }
    }
}
