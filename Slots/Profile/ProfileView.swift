import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var completion: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.completion(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ProfileView: View {
    @StateObject var profileModel =  ProfileViewModel()
    @State private var isTimerRunning: Bool = UserDefaults.standard.bool(forKey: "isTimerRunning")
    @State private var buttonDisabledUntil: Date? = UserDefaults.standard.object(forKey: "buttonDisabledUntil") as? Date
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage? = nil
    @Binding var isShow: Bool
    let userDefaultsPhotoKey = "profilePhoto"
    
    func startTimer() {
        let now = Date()
        let disableUntil = Calendar.current.date(byAdding: .hour, value: 24, to: now)!
        UserDefaults.standard.set(true, forKey: "isTimerRunning")
        UserDefaults.standard.set(disableUntil, forKey: "buttonDisabledUntil")
        isTimerRunning = true
        buttonDisabledUntil = disableUntil
    }
    
    func isButtonDisabled() -> Bool {
        guard let disabledUntil = buttonDisabledUntil else { return false }
        return Date() < disabledUntil
    }
    
    func checkTimerStatus() {
        if let disabledUntil = buttonDisabledUntil {
            if Date() >= disabledUntil {
                isTimerRunning = false
                buttonDisabledUntil = nil
                UserDefaults.standard.set(false, forKey: "isTimerRunning")
                UserDefaults.standard.removeObject(forKey: "buttonDisabledUntil")
            } else {
                isTimerRunning = true
            }
        } else {
            isTimerRunning = false
        }
    }
    
    func timeRemainingString(until endDate: Date) -> String {
        let currentDate = Date()
        let interval = endDate.timeIntervalSince(currentDate)
        
        if interval <= 0 {
            return "00:00"
        }
        
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            
            VStack {
                ZStack(alignment: .topTrailing) {
                    Rectangle()
                        .fill(Color(red: 10/255, green: 86/255, blue: 44/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 241/255, green: 177/255, blue: 0/255), lineWidth: 4)
                                .overlay {
                                    VStack(spacing: 5) {
                                        HStack {
                                            Image(.personYellow)
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                            
                                            Text("PLAYER PROFILE")
                                                .Bold(size: 30, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                        }
                                        
                                        Spacer()
                                        
                                        HStack(spacing: 25) {
                                            Rectangle()
                                                .fill(Color(red: 0/255, green: 130/255, blue: 54/255)).opacity(0.5)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(red: 241/255, green: 177/255, blue: 0/255).opacity(0.3), lineWidth: 4)
                                                        .overlay {
                                                            VStack {
                                                                ZStack(alignment: .bottom) {
                                                                    ZStack {
                                                                        Circle()
                                                                            .fill(Color(red: 254/255, green: 223/255, blue: 33/255))
                                                                            .frame(width: 85, height: 85)
                                                                        
                                                                        Circle()
                                                                            .fill(LinearGradient(colors: [Color(red: 253/255, green: 199/255, blue: 2/255),
                                                                                                          Color(red: 208/255, green: 135/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                                                                            .frame(width: 77, height: 77)
                                                                        
                                                                        if let image = selectedImage {
                                                                            Image(uiImage: image)
                                                                                .resizable()
                                                                                .scaledToFill()
                                                                                .frame(width: 77, height: 77)
                                                                                .clipShape(Circle())
                                                                        } else {
                                                                            Image("personGreen")
                                                                                .resizable()
                                                                                .frame(width: 48, height: 48)
                                                                        }
                                                                    }
                                                                    
                                                                    Button(action: {
                                                                        showingImagePicker = true
                                                                    }) {
                                                                        ZStack {
                                                                            Circle()
                                                                                .fill(Color(red: 254/255, green: 223/255, blue: 33/255))
                                                                                .frame(width: 31, height: 31)
                                                                            
                                                                            Circle()
                                                                                .fill(Color(red: 1/255, green: 102/255, blue: 48/255))
                                                                                .frame(width: 28, height: 28)
                                                                            
                                                                            Image(.camera)
                                                                                .resizable()
                                                                                .frame(width: 19, height: 19)
                                                                        }
                                                                    }
                                                                    .offset(y: 10)
                                                                }
                                                                .sheet(isPresented: $showingImagePicker) {
                                                                    ImagePicker { image in
                                                                        selectedImage = image
                                                                        saveImageToUserDefaults(image)
                                                                    }
                                                                }
                                                                .onAppear {
                                                                    if let savedImage = loadImageFromUserDefaults() {
                                                                        selectedImage = savedImage
                                                                    }
                                                                }
                                                                
                                                                
                                                                LevelProgressView(currentPoints: GameStatsManager.shared.levelCount)
                                                            }
                                                        }
                                                }
                                                .frame(width: 221, height: 180)
                                                .cornerRadius(16)
                                            
                                            Rectangle()
                                                .fill(Color(red: 0/255, green: 130/255, blue: 54/255)).opacity(0.5)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(red: 241/255, green: 177/255, blue: 0/255).opacity(0.3), lineWidth: 4)
                                                        .overlay {
                                                            VStack {
                                                                Image(.dollar2)
                                                                    .resizable()
                                                                    .frame(width: 48, height: 48)
                                                                
                                                                Text("Current Balance")
                                                                    .Bold(size: 15, color: Color(red: 253/255, green: 199/255, blue: 2/255))
                                                                
                                                                Text("$\(UserDefaults.standard.integer(forKey: "coin"))")
                                                                    .Bold(size: 20, color: Color(red: 253/255, green: 199/255, blue: 2/255))
                                                                
                                                                if isTimerRunning {
                                                                    Rectangle()
                                                                        .fill(LinearGradient(colors: [Color(red: 132/255, green: 132/255, blue: 132/255),
                                                                                                      Color(red: 206/255, green: 206/255, blue: 206/255)], startPoint: .leading, endPoint: .trailing))
                                                                        .overlay {
                                                                            HStack(spacing: 5) {
                                                                                Image(.gift)
                                                                                    .resizable()
                                                                                    .frame(width: 16, height: 16)
                                                                                
                                                                                if let endDate = buttonDisabledUntil {
                                                                                    let remaining = timeRemainingString(until: endDate)
                                                                                    Text("Next will be in \(remaining)")
                                                                                        .Bold(size: 10, color: Color(red: 14/255, green: 84/255, blue: 43/255))
                                                                                }
                                                                            }
                                                                        }
                                                                        .frame(width: 134, height: 30)
                                                                        .cornerRadius(16)
                                                                } else {
                                                                    Button(action: {
                                                                        let balance = UserDefaults.standard.integer(forKey: "coin")
                                                                        UserDefaults.standard.set(balance + 1000, forKey: "coin")
                                                                        NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
                                                                        startTimer()
                                                                    }) {
                                                                        Rectangle()
                                                                            .fill(LinearGradient(colors: [Color(red: 253/255, green: 199/255, blue: 2/255),
                                                                                                          Color(red: 241/255, green: 177/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                                                                            .overlay {
                                                                                HStack(spacing: 5) {
                                                                                    Image(.gift)
                                                                                        .resizable()
                                                                                        .frame(width: 16, height: 16)
                                                                                    
                                                                                    Text("GET BONUS  $1000")
                                                                                        .Bold(size: 10, color: Color(red: 14/255, green: 84/255, blue: 43/255))
                                                                                }
                                                                            }
                                                                            .frame(width: 134, height: 30)
                                                                            .cornerRadius(16)
                                                                    }
                                                                }
                                                            }
                                                        }
                                                }
                                                .frame(width: 221, height: 170)
                                                .cornerRadius(16)
                                        }
                                        
                                        Spacer()
                                        
                                        HStack(spacing: 15) {
                                            Rectangle()
                                                .fill(Color(red: 0/255, green: 130/255, blue: 54/255)).opacity(0.5)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(red: 241/255, green: 177/255, blue: 0/255).opacity(0.3), lineWidth: 4)
                                                        .overlay {
                                                            VStack(spacing: 1) {
                                                                Image(.game)
                                                                    .resizable()
                                                                    .frame(width: 32, height: 32)
                                                                
                                                                Text("\(GameStatsManager.shared.playedGamesCount)")
                                                                    .Bold(size: 20, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                                
                                                                Text("Games Played")
                                                                    .Regular(size: 12, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                            }
                                                        }
                                                }
                                                .frame(width: 106, height: 84)
                                                .cornerRadius(16)
                                            
                                            Rectangle()
                                                .fill(Color(red: 0/255, green: 130/255, blue: 54/255)).opacity(0.5)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(red: 241/255, green: 177/255, blue: 0/255).opacity(0.3), lineWidth: 4)
                                                        .overlay {
                                                            VStack(spacing: 1) {
                                                                Image(.winrate)
                                                                    .resizable()
                                                                    .frame(width: 32, height: 32)
                                                                
                                                                Text(GameStatsManager.shared.winRateString)
                                                                    .Bold(size: 20, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                                
                                                                Text("Win Rate")
                                                                    .Regular(size: 12, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                            }
                                                        }
                                                }
                                                .frame(width: 106, height: 84)
                                                .cornerRadius(16)
                                            
                                            Rectangle()
                                                .fill(Color(red: 0/255, green: 130/255, blue: 54/255)).opacity(0.5)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(red: 241/255, green: 177/255, blue: 0/255).opacity(0.3), lineWidth: 4)
                                                        .overlay {
                                                            VStack(spacing: 1) {
                                                                Image(.biggestWin)
                                                                    .resizable()
                                                                    .frame(width: 24, height: 24)
                                                                
                                                                Text("\(GameStatsManager.shared.maxWin)")
                                                                    .Bold(size: 20, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                                
                                                                Text("Biggest Win")
                                                                    .Regular(size: 12, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                            }
                                                        }
                                                }
                                                .frame(width: 106, height: 84)
                                                .cornerRadius(16)
                                            
                                            Rectangle()
                                                .fill(Color(red: 0/255, green: 130/255, blue: 54/255)).opacity(0.5)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(red: 241/255, green: 177/255, blue: 0/255).opacity(0.3), lineWidth: 4)
                                                        .overlay {
                                                            VStack(spacing: 1) {
                                                                Image(.dollar2)
                                                                    .resizable()
                                                                    .frame(width: 32, height: 32)
                                                                
                                                                Text("\(GameStatsManager.shared.totalWinsSum)")
                                                                    .Bold(size: 20, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                                
                                                                Text("Total Winnings")
                                                                    .Regular(size: 12, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                            }
                                                        }
                                                }
                                                .frame(width: 106, height: 84)
                                                .cornerRadius(16)
                                        }
                                    }
                                    .padding(.vertical, 25)
                                }
                        }
                        .frame(width: 539, height: 362)
                        .cornerRadius(16)
                    
                    Button(action: {
                        isShow.toggle()
                    }) {
                        Image(.closeBtn)
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    .offset(x: 5, y: -5)
                }
            }
        }
        .onAppear {
            checkTimerStatus()
        }
    }
    
    func saveImageToUserDefaults(_ image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            UserDefaults.standard.set(data, forKey: userDefaultsPhotoKey)
        }
    }
    
    func loadImageFromUserDefaults() -> UIImage? {
        if let data = UserDefaults.standard.data(forKey: userDefaultsPhotoKey),
           let image = UIImage(data: data) {
            return image
        }
        return nil
    }
}

struct LevelProgressView: View {
    let currentPoints: Int
    private let pointsPerLevel = 100
    private let maxBarWidth: CGFloat = 170

    var currentLevel: Int {
        currentPoints / pointsPerLevel
    }

    var progressPercent: Double {
        Double(currentPoints % pointsPerLevel) / Double(pointsPerLevel)
    }

    var body: some View {
        VStack(spacing: 5) {
            Text("Level \(currentLevel)")
                .Regular(size: 16, color: Color(red: 255/255, green: 240/255, blue: 133/255))

            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color(red: 1/255, green: 102/255, blue: 48/255))
                    .frame(width: maxBarWidth, height: 12)
                    .cornerRadius(16)

                Rectangle()
                    .fill(LinearGradient(colors: [Color(red: 253/255, green: 199/255, blue: 2/255),
                                                 Color(red: 241/255, green: 177/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                    .frame(width: maxBarWidth * CGFloat(progressPercent), height: 12)
                    .cornerRadius(16)
            }

            Text(String(format: "%.0f%% to Level %d", progressPercent * 100, currentLevel + 1))
                .Regular(size: 14, color: Color(red: 255/255, green: 240/255, blue: 133/255))
        }
        .padding(.top, 5)
    }
}


#Preview {
    ProfileView(isShow: .constant(false))
}

final class GameStatsManager {
    static let shared = GameStatsManager()
    private let defaults = UserDefaults.standard
    
    private let playedGamesKey = "playedGamesCount"
    private let wonGamesKey = "wonGamesCount"
    private let winsArrayKey = "winsArray"
    private let level = "level"
    
    private init() {}

    var playedGamesCount: Int {
        get { defaults.integer(forKey: playedGamesKey) }
        set { defaults.set(newValue, forKey: playedGamesKey) }
    }
    
    func incrementPlayedGames() {
        playedGamesCount += 1
    }
    
    var levelCount: Int {
        get { defaults.integer(forKey: level) }
        set { defaults.set(newValue, forKey: level) }
    }
    
    func increaseLebel(value: Int = 10) {
        levelCount += value
    }
    
    var wonGamesCount: Int {
        get { defaults.integer(forKey: wonGamesKey) }
        set { defaults.set(newValue, forKey: wonGamesKey) }
    }
    
    func incrementWonGames() {
        wonGamesCount += 1
    }
    
    var winRateString: String {
        guard playedGamesCount > 0 else { return "0%" }
        return String(format: "%.0f", (Double(wonGamesCount) / Double(playedGamesCount)) * 100) + "%"
    }
    
    var winsArray: [Int] {
        get { defaults.array(forKey: winsArrayKey) as? [Int] ?? [] }
        set { defaults.set(newValue, forKey: winsArrayKey) }
    }
    
    func addWin(amount: Int) {
        var currentWins = winsArray
        currentWins.append(amount)
        winsArray = currentWins
    }
    
    var maxWin: Int {
        return winsArray.max() ?? 0
    }
    
    var totalWinsSum: Int {
        return winsArray.reduce(0, +)
    }
    
    func resetStats() {
        defaults.removeObject(forKey: playedGamesKey)
        defaults.removeObject(forKey: wonGamesKey)
        defaults.removeObject(forKey: winsArrayKey)
    }
}
