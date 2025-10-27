import SwiftUI

@main
struct CasinoHubApp: App {
    init() {
        let stats = UserDefaultsManager.shared
        let key = "didAddInitialCoins"
        if !UserDefaults.standard.bool(forKey: key) {
            stats.addCoins(5000)
            stats.setFirstGamePlayed()
            UserDefaults.standard.set(true, forKey: key)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HubTabBarView()
        }
    }
}
