import SwiftUI

class HubSettingsViewModel: ObservableObject {
    let contact = HubSettingsModel()
    @Published var isOn: Bool {
        didSet {
            UserDefaults.standard.set(isOn, forKey: "isOns")
            NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
        }
    }
    @Published var isNotifOn: Bool {
        didSet {
            UserDefaults.standard.set(isNotifOn, forKey: "isNotifOn")
        }
    }
    @Published var isVib: Bool {
        didSet {
            UserDefaults.standard.set(isVib, forKey: "isVib")
        }
    }
    
    init() {
        self.isOn = UserDefaults.standard.bool(forKey: "isOns")
        self.isNotifOn = UserDefaults.standard.bool(forKey: "isNotifOn")
        self.isVib = UserDefaults.standard.bool(forKey: "isVib")
    }
}
