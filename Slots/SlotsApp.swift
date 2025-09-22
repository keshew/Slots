import SwiftUI

@main
struct SlotsApp: App {
    
    init() {
        let defaults = UserDefaults.standard
        let hasLaunchedKey = "hasLaunchedBefore"
        
        if !defaults.bool(forKey: hasLaunchedKey) {
            defaults.set(5000, forKey: "coin")
            defaults.set(true, forKey: hasLaunchedKey)
            UserDefaults.standard.set(0.5, forKey: "musicVolume")
            UserDefaults.standard.set(0.5, forKey: "soundVolume")
            UserDefaults.standard.set(true, forKey: "isAudioOn")
            defaults.synchronize()
            GameStatsManager.shared.increaseLebel(value: 100)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
