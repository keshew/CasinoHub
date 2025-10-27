import SwiftUI

class HubMainViewModel: ObservableObject {
    let contact = HubMainModel()
    @Published var coins = 0
    
    init() {
        self.coins = UserDefaultsManager.shared.coins
        NotificationCenter.default.addObserver(forName: Notification.Name("UserResourcesUpdated"), object: nil, queue: .main) { _ in
            self.coins = UserDefaultsManager.shared.coins
        }
    }
}
