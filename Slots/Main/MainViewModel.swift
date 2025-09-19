import SwiftUI

class MainViewModel: ObservableObject {
    let contact = MainModel()
    @Published var coins: Int = 0
    
    init() {
        self.coins = UserDefaults.standard.integer(forKey: "coin")
        
        NotificationCenter.default.addObserver(forName: Notification.Name("UserResourcesUpdated"), object: nil, queue: .main) { _ in
            self.coins = UserDefaults.standard.integer(forKey: "coin")
        }
    }
}
