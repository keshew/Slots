import SwiftUI
import SpriteKit

struct GameView: View {
    @StateObject var gameModel: GameViewModel
    @Binding var currentIndex: Int
    @Environment(\.presentationMode) var presentationMode
    @State private var showWinPopup = false
    @State var isSettings = false
    @State var isProfile = false
    @State var showAlert = false
    @ObservedObject private var soundManager = SoundManager.shared
    
    var selected: String {
        switch currentIndex {
        case 0:
            return "Classic slots"
        case 1:
            return "Neptune slots"
        case 2:
            return "Ruby slots"
        case 3:
            return "Amethyst slots"
        default:
            return "Classic slots"
        }
    }
    
    var selectedBG: String {
        switch currentIndex {
        case 0:
            return "bg1"
        case 1:
            return "bg2"
        case 2:
            return "bg3"
        case 3:
            return "bg4"
        default:
            return "bg1"
        }
    }
    
    var fontColor: Color {
        switch currentIndex {
        case 0:
            return Color(red: 18/255, green: 84/255, blue: 13/255)
        case 1:
            return Color(red: 15/255, green: 64/255, blue: 84/255)
        case 2:
            return Color(red: 193/255, green: 0/255, blue: 7/255)
        case 3:
            return Color(red: 120/255, green: 1/255, blue: 130/255)
        default:
            return Color(red: 15/255, green: 64/255, blue: 84/255)
        }
    }
    
    var linearGradient: LinearGradient {
        switch currentIndex {
        case 0:
            return LinearGradient(colors: [Color(red: 8/255, green: 102/255, blue: 4/255),
                                           Color(red: 0/255, green: 130/255, blue: 10/255),
                                           Color(red: 8/255, green: 102/255, blue: 4/255)], startPoint: .leading, endPoint: .trailing)
        case 1:
            return LinearGradient(colors: [Color(red: 4/255, green: 75/255, blue: 102/255),
                                           Color(red: 0/255, green: 95/255, blue: 130/255),
                                           Color(red: 14/255, green: 44/255, blue: 102/255)], startPoint: .leading, endPoint: .trailing)
        case 2:
            return LinearGradient(colors: [Color(red: 102/255, green: 12/255, blue: 14/255),
                                           Color(red: 130/255, green: 6/255, blue: 12/255),
                                           Color(red: 102/255, green: 12/255, blue: 14/255)], startPoint: .leading, endPoint: .trailing)
        case 3:
            return LinearGradient(colors: [Color(red: 86/255, green: 12/255, blue: 102/255),
                                           Color(red: 119/255, green: 7/255, blue: 130/255),
                                           Color(red: 14/255, green: 44/255, blue: 102/255)], startPoint: .leading, endPoint: .trailing)
        default:
            return LinearGradient(colors: [Color(red: 4/255, green: 75/255, blue: 102/255),
                                           Color(red: 0/255, green: 95/255, blue: 130/255),
                                           Color(red: 100/255, green: 12/255, blue: 102/255)], startPoint: .leading, endPoint: .trailing)
        }
    }
    
    var backSettingsBtn: Color {
        switch currentIndex {
        case 0:
            return Color(red: 5/255, green: 157/255, blue: 2/255)
        case 1:
            return Color(red: 3/255, green: 149/255, blue: 149/255)
        case 2:
            return Color(red: 156/255, green: 1/255, blue: 0/255)
        case 3:
            return Color(red: 124/255, green: 1/255, blue: 149/255)
        default:
            return Color(red: 130/255, green: 1/255, blue: 154/255)
        }
    }
    
    var overlaySettingsBtn: Color {
        switch currentIndex {
        case 0:
            return Color(red: 80/255, green: 172/255, blue: 1/255)
        case 1:
            return Color(red: 76/255, green: 173/255, blue: 110/255)
        case 2:
            return Color(red: 187/255, green: 65/255, blue: 1/255)
        case 3:
            return Color(red: 161/255, green: 66/255, blue: 102/255)
        default:
            return Color(red: 130/255, green: 1/255, blue: 154/255)
        }
    }
    
    var descBack: Color {
        switch currentIndex {
        case 0:
            return Color(red: 10/255, green: 86/255, blue: 44/255)
        case 1:
            return Color(red: 7/255, green: 58/255, blue: 94/255)
        case 2:
            return Color(red: 92/255, green: 8/255, blue: 11/255)
        case 3:
            return Color(red: 59/255, green: 11/255, blue: 89/255)
        default:
            return Color(red: 130/255, green: 1/255, blue: 154/255)
        }
    }
    
    var line: Color {
        switch currentIndex {
        case 0:
            return Color(red: 0/255, green: 130/255, blue: 54/255)
        case 1:
            return Color(red: 70/255, green: 159/255, blue: 213/255)
        case 2:
            return Color(red: 105/255, green: 12/255, blue: 16/255)
        case 3:
            return Color(red: 162/255, green: 44/255, blue: 211/255)
        default:
            return Color(red: 130/255, green: 1/255, blue: 154/255)
        }
    }
    
    var itemBack: Color {
        switch currentIndex {
        case 0:
            return Color(red: 4/255, green: 108/255, blue: 50/255)
        case 1:
            return Color(red: 3/255, green: 70/255, blue: 114/255)
        case 2:
            return Color(red: 120/255, green: 0/255, blue: 10/255)
        case 3:
            return Color(red: 89/255, green: 1/255, blue: 122/255)
        default:
            return Color(red: 130/255, green: 1/255, blue: 154/255)
        }
    }
    
    var winningLine: String {
        switch currentIndex {
        case 0:
            return "winingLines1"
        case 1:
            return "winingLines2"
        case 2:
            return "winingLines3"
        case 3:
            return "winingLines4"
        default:
            return "winingLines1"
        }
    }
    
    init(currentIndex: Binding<Int>) {
        _currentIndex = currentIndex
        _gameModel = StateObject(wrappedValue: GameViewModel(currentIndex: currentIndex.wrappedValue))
    }
    
    var body: some View {
        ZStack {
            Image(selectedBG)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    ZStack(alignment: .bottom) {
                        linearGradient
                            .frame(height: UIScreen.main.bounds.size.height > 700 ? 100 : 75)
                        
                        Rectangle()
                            .fill(Color(red: 253/255, green: 199/255, blue: 2/255))
                            .frame(height: 3)
                    }
                    .ignoresSafeArea(edges: [.top, .horizontal])
                    
                    HStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                                NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(backSettingsBtn)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(overlaySettingsBtn, lineWidth: 3)
                                        }
                                        .frame(width: 73, height: 40)
                                        .cornerRadius(20)
                                    
                                    HStack {
                                        Image(.left)
                                            .resizable()
                                            .frame(width: 19, height: 19)
                                        
                                        Text("Back")
                                            .Bold(size: 12, color: Color(red: 254/255, green: 207/255, blue: 14/255))
                                    }
                                }
                            }
                            
                            Button(action: {
                                isProfile = true
                            }) {
                                ZStack {
                                    Circle()
                                        .stroke(overlaySettingsBtn, lineWidth: 3)
                                        .frame(width: 35, height: 35)
                                    
                                    Circle()
                                        .fill(backSettingsBtn)
                                        .frame(width: 35, height: 35)
                                    
                                    Image(.info)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                }
                            }
                            
                            Button(action: {
                                isSettings = true
                            }) {
                                ZStack {
                                    Circle()
                                        .stroke(overlaySettingsBtn, lineWidth: 3)
                                        .frame(width: 35, height: 35)
                                    
                                    Circle()
                                        .fill(backSettingsBtn)
                                        .frame(width: 35, height: 35)
                                    
                                    Image(.settings)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Rectangle()
                            .fill(Color(red: 253/255, green: 199/255, blue: 2/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 255/255, green: 222/255, blue: 30/255), lineWidth: 3)
                                    .overlay {
                                        Text("WIN : \(gameModel.win)")
                                            .Bold(size: 17, color: fontColor)
                                    }
                            }
                            .frame(width: 202, height: 48)
                            .cornerRadius(16)
                            .padding(.trailing)
                        
                        Spacer()
                        
                        ZStack(alignment: .trailing) {
                            Image(.yellowBack)
                                .resizable()
                                .frame(width: 150, height: 38)
                                .overlay {
                                    Text("BALANCE \(gameModel.balance)")
                                        .Bold(size: 12, color: fontColor)
                                        .offset(x: -15)
                                }
                            
                            ZStack {
                                Circle()
                                    .stroke(overlaySettingsBtn, lineWidth: 3)
                                
                                Circle()
                                    .fill(backSettingsBtn)
                                
                                Image(.dollar)
                                    .resizable()
                                    .frame(width: 11, height: 16)
                            }
                            .frame(width: 39, height: 38)
                        }
                    }
                    .offset(y: UIScreen.main.bounds.size.height > 700 ? -20 : 0)
                    .padding(.horizontal, UIScreen.main.bounds.size.height > 700 ? 20 : 0)
                }
                
                Spacer()
                
                HStack(spacing: 60) {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(descBack)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 241/255, green: 177/255, blue: 0/255), lineWidth: 4)
                                    .overlay {
                                        VStack(spacing: 15) {
                                            HStack(alignment: .bottom) {
                                                Button(action: {
                                                    if gameModel.bet > 50 {
                                                        gameModel.bet -= 50
                                                    }
                                                }) {
                                                    ZStack {
                                                        Circle()
                                                            .stroke(Color(red: 255/255, green: 100/255, blue: 103/255), lineWidth: 3)
                                                            .frame(width: 39, height: 39)
                                                        
                                                        Circle()
                                                            .fill(Color(red: 206/255, green: 0/255, blue: 9/255))
                                                            .frame(width: 38, height: 38)
                                                        
                                                        Text("-")
                                                            .Bold(size: 26)
                                                            .offset(y: -1)
                                                    }
                                                }
                                                
                                                VStack(spacing: 5) {
                                                    Text("BET")
                                                        .Bold(size: 18, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                    
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 222/255, blue: 30/255),
                                                                                      Color(red: 241/255, green: 177/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(Color(red: 255/255, green: 222/255, blue: 30/255), lineWidth: 5)
                                                                .overlay {
                                                                    Text("$\(gameModel.bet)")
                                                                        .Bold(size: 16, color: fontColor)
                                                                        .minimumScaleFactor(0.7)
                                                                }
                                                        }
                                                        .frame(width: UIScreen.main.bounds.size.height > 1000 ? 192 : UIScreen.main.bounds.size.height > 700 ? 92 : 92, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                        .cornerRadius(16)
                                                }
                                                
                                                Button(action: {
                                                    if gameModel.bet < gameModel.balance {
                                                        gameModel.bet += 50
                                                    }
                                                }) {
                                                    ZStack {
                                                        Circle()
                                                            .stroke(overlaySettingsBtn, lineWidth: 3)
                                                            .frame(width: 39, height: 39)
                                                        
                                                        Circle()
                                                            .fill(backSettingsBtn)
                                                            .frame(width: 38, height: 38)
                                                        
                                                        Text("+")
                                                            .Bold(size: 26)
                                                            .offset(y: -1)
                                                    }
                                                }
                                            }
                                            .padding(.top, 5)
                                            
                                            VStack(spacing: 0) {
                                                HStack {
                                                    Button(action: {
                                                        if gameModel.balance >= 250 {
                                                            gameModel.bet = 250
                                                        }
                                                    }) {
                                                        Rectangle()
                                                            .fill(LinearGradient(colors: [backSettingsBtn], startPoint: .leading, endPoint: .trailing))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(overlaySettingsBtn, lineWidth: 5)
                                                                    .overlay {
                                                                        Text("250")
                                                                            .Bold(size: 16, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                                    }
                                                            }
                                                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 92 : UIScreen.main.bounds.size.height > 800 ? 72 : 52, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                            .cornerRadius(16)
                                                    }
                                                    
                                                    Button(action: {
                                                        if gameModel.balance >= 500 {
                                                            gameModel.bet = 500
                                                        }
                                                    }) {
                                                        Rectangle()
                                                            .fill(LinearGradient(colors: [backSettingsBtn], startPoint: .leading, endPoint: .trailing))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(overlaySettingsBtn, lineWidth: 5)
                                                                    .overlay {
                                                                        Text("500")
                                                                            .Bold(size: 16, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                                    }
                                                            }
                                                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 92 : UIScreen.main.bounds.size.height > 800 ? 72 : 52, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                            .cornerRadius(16)
                                                    }
                                                    
                                                    Button(action: {
                                                        if gameModel.balance >= 1000 {
                                                            gameModel.bet = 1000
                                                        }
                                                    }) {
                                                        Rectangle()
                                                            .fill(LinearGradient(colors: [backSettingsBtn], startPoint: .leading, endPoint: .trailing))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(overlaySettingsBtn, lineWidth: 5)
                                                                    .overlay {
                                                                        Text("1000")
                                                                            .Bold(size: 16, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                                    }
                                                            }
                                                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 92 : UIScreen.main.bounds.size.height > 800 ? 72 : 52, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                            .cornerRadius(16)
                                                    }
                                                }
                                                
                                                Image(winningLine)
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.size.height > 1000 ? 350 : UIScreen.main.bounds.size.height > 800 ? 260 : 197, height: UIScreen.main.bounds.size.height > 1000 ? 195 : UIScreen.main.bounds.size.height > 800 ? 145 : 100)
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                            }
                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 400 : UIScreen.main.bounds.size.height > 800 ? 290 : 238, height: UIScreen.main.bounds.size.height > 1000 ? 380 : UIScreen.main.bounds.size.height > 800 ? 320 : 242)
                            .cornerRadius(16)
                        
                        Button(action: {
                            gameModel.bet = gameModel.balance
                        }) {
                            Rectangle()
                                .fill(Color(red: 253/255, green: 199/255, blue: 2/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 255/255, green: 222/255, blue: 30/255), lineWidth: 3)
                                        .overlay {
                                            Text("MAX BET")
                                                .Bold(size: 17, color: fontColor)
                                        }
                                }
                                .frame(width: UIScreen.main.bounds.size.height > 800 ? 220 : 206, height: UIScreen.main.bounds.size.height > 800 ? 40 : 30)
                                .cornerRadius(16)
                        }
                        .offset(y: 15)
                    }
                    
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 254/255, green: 223/255, blue: 33/255),
                                                          Color(red: 253/255, green: 199/255, blue: 2/255),
                                                          Color(red: 208/255, green: 135/255, blue: 0/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color(red: 255/255, green: 240/255, blue: 133/255), lineWidth: 7)
                                    .overlay {
                                        Rectangle()
                                            .fill(descBack)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color(red: 241/255, green: 177/255, blue: 0/255), lineWidth: 4)
                                                    .overlay {
                                                        VStack {
                                                            VStack(spacing: 0) {
                                                                ForEach(0..<3, id: \.self) { row in
                                                                    HStack(spacing: 5) {
                                                                        ForEach(0..<5, id: \.self) { col in
                                                                            HStack(spacing: 5) {
                                                                                Rectangle()
                                                                                    .fill(LinearGradient(colors: [itemBack], startPoint: .top, endPoint: .bottom))
                                                                                    .overlay {
                                                                                        RoundedRectangle(cornerRadius: 16)
                                                                                            .stroke(Color(red: 241/255, green: 177/255, blue: 0/255), lineWidth: 4)
                                                                                            .overlay {
                                                                                                Image(gameModel.board[row][col])
                                                                                                    .resizable()
                                                                                                    .frame(width: 45, height: 45)
                                                                                                    .opacity(gameModel.isSpinning ? 0.5 : 1.0)
                                                                                            }
                                                                                    }
                                                                                    .frame(width: UIScreen.main.bounds.size.height > 1000 ? 90 : UIScreen.main.bounds.size.height > 800 ? 70 : 58, height: UIScreen.main.bounds.size.height > 1000 ? 90 : UIScreen.main.bounds.size.height > 800 ? 70 : 59)
                                                                                    .transition(.move(edge: .bottom))
                                                                                    .cornerRadius(16)
                                                                                    .shadow(color: gameModel.winningPositions.contains(where: { $0.row == row && $0.col == col }) ? backSettingsBtn : .clear, radius: gameModel.isSpinning ? 0 : 10)
                                                                                
                                                                                if col <= 3 {
                                                                                    Rectangle()
                                                                                        .fill(LinearGradient(colors: [line], startPoint: .top, endPoint: .bottom))
                                                                                        .frame(width: 3, height: UIScreen.main.bounds.size.height > 1000 ? 100 : UIScreen.main.bounds.size.height > 800 ? 80 : 65)
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            
                                                            Rectangle()
                                                                .fill(LinearGradient(colors: [line], startPoint: .top, endPoint: .bottom))
                                                                .frame(width: UIScreen.main.bounds.size.height > 1000 ? 500 : UIScreen.main.bounds.size.height > 800 ? 390 : 334, height: 3)
                                                            
                                                            VStack {
                                                                HStack(spacing: 17) {
                                                                    ForEach(0..<gameModel.arrayOfImage.count, id: \.self) { index in
                                                                        Image(gameModel.arrayOfImage[index])
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fit)
                                                                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 47 : UIScreen.main.bounds.size.height > 800 ? 33 : 27, height: UIScreen.main.bounds.size.height > 1000 ? 50 : UIScreen.main.bounds.size.height > 800 ? 31 : 24)
                                                                    }
                                                                }
                                                                
                                                                Image(.bonusCount)
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: UIScreen.main.bounds.size.height > 1000 ? 500 : UIScreen.main.bounds.size.height > 800 ? 390 : 340, height: UIScreen.main.bounds.size.height > 1000 ? 80 : UIScreen.main.bounds.size.height > 800 ? 60 : 31)
                                                            }
                                                        }
                                                    }
                                            }
                                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 560 : UIScreen.main.bounds.size.height > 800 ? 460 : 392, height: UIScreen.main.bounds.size.height > 1000 ? 500 : UIScreen.main.bounds.size.height > 800 ? 385 : 295)
                                            .cornerRadius(16)
                                    }
                            }
                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 600 : UIScreen.main.bounds.size.height > 800 ? 500 : 435, height: UIScreen.main.bounds.size.height > 1000 ? 550 : UIScreen.main.bounds.size.height > 800 ? 400 : 310)
                            .cornerRadius(24)
                        
                        Button(action: {
                            if gameModel.balance != 0, gameModel.balance >= gameModel.bet {
                                gameModel.spin()
                                GameStatsManager.shared.increaseLebel(value: 10)
                                GameStatsManager.shared.incrementPlayedGames()
                                
                                switch currentIndex {
                                case 0:
                                    soundManager.playSlot1()
                                case 1:
                                    soundManager.playSlot2()
                                case 2:
                                    soundManager.playSlot3()
                                case 3:
                                    soundManager.playSlot4()
                                default:
                                    soundManager.playSlot1()
                                }
                            } else {
                                showAlert = true
                            }
                        }) {
                            Rectangle()
                                .fill(descBack)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 255/255, green: 222/255, blue: 30/255), lineWidth: 3)
                                        .overlay {
                                            Text("Spin")
                                                .Bold(size: 14, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                        }
                                }
                                .frame(width: UIScreen.main.bounds.size.height > 800 ? 130 : 116, height: UIScreen.main.bounds.size.height > 800 ? 44 : 34)
                                .cornerRadius(16)
                        }
                        .offset(y: UIScreen.main.bounds.size.height > 440 ? 25 : 15)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Not enough coins"),
                                message: Text("You do not have enough coins to spin."),
                                dismissButton: .default(Text("Ok"))
                            )
                        }
                    }
                }
                
                Spacer()
            }
            
            if isProfile {
                ProfileView(isShow: $isProfile)
            }
            
            if isSettings {
                SettingsView(isShow: $isSettings)
            }
            
            if gameModel.win > 0 && showWinPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                ZStack {
                    ImageEmitterView(imageName: "coin3")
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        
                        Image(.win)
                            .resizable()
                            .frame(width: 421, height: 167)
                        
                        Spacer()
                        
                        Button(action: {
                            gameModel.balance += gameModel.win
                            UserDefaults.standard.set(gameModel.balance, forKey: "coin")
                            GameStatsManager.shared.incrementWonGames()
                            GameStatsManager.shared.addWin(amount: gameModel.win)
                            gameModel.win = 0
                        }) {
                            Rectangle()
                                .fill(descBack)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 255/255, green: 222/255, blue: 30/255), lineWidth: 3)
                                        .overlay {
                                            Text("Claim")
                                                .Bold(size: 20, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                        }
                                }
                                .frame(width: 177, height: 52)
                                .cornerRadius(16)
                        }
                        
                        Spacer()
                    }
                }
                .offset(x: 10, y: 30)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .onChange(of: gameModel.win) { newValue in
            if newValue > 0 {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    showWinPopup = true
                }
            } else {
                withAnimation {
                    showWinPopup = false
                }
            }
        }
    }
}

#Preview {
    GameView(currentIndex: .constant(0))
}

class ImageEmitterScene: SKScene {
    let particleTexture: SKTexture
    var spawnTimer: Timer?
    
    init(size: CGSize, imageName: String) {
        self.particleTexture = SKTexture(imageNamed: imageName)
        super.init(size: size)
        backgroundColor = .clear
        scaleMode = .resizeFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        startSpawning()
    }
    
    override func willMove(from view: SKView) {
        spawnTimer?.invalidate()
    }
    
    func startSpawning() {
        spawnTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.spawnParticle()
        }
    }
    
    func spawnParticle() {
        let particle = SKSpriteNode(texture: particleTexture)
        particle.size = CGSize(width: 33, height: 33)
        let xPos = CGFloat.random(in: 0...size.width)
        particle.position = CGPoint(x: xPos, y: size.height + particle.size.height)
        particle.zPosition = 1
        addChild(particle)
        
        let duration = Double.random(in: 5.0...12.0)
        let moveAction = SKAction.moveTo(y: -particle.size.height, duration: duration)
        let removeAction = SKAction.removeFromParent()
        particle.run(SKAction.sequence([moveAction, removeAction]))
    }
}

struct ImageEmitterView: View {
    let scene: SKScene
    
    init(imageName: String) {
        let screenSize = UIScreen.main.bounds.size
        scene = ImageEmitterScene(size: screenSize, imageName: imageName)
    }
    
    var body: some View {
        SpriteView(
            scene: scene,
            options: [.allowsTransparency]
        )
        .ignoresSafeArea()
        .background(Color.clear)
    }
}
