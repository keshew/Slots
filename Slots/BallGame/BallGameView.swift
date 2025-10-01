import SwiftUI
import SpriteKit

struct BallGameView: View {
    @StateObject var ballGameModel =  BallGameViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showWinPopup = false
    @State var isSettings = false
    @State var isProfile = false
    @State var showAlert = false
    @ObservedObject private var soundManager = SoundManager.shared
    @StateObject var gameModel = GameData()
    
    var body: some View {
        ZStack {
            Image(.bg5)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [Color(red: 248/255, green: 62/255, blue: 208/255),
                                                Color(red: 228/255, green: 41/255, blue: 226/255),
                                                Color(red: 222/255, green: 17/255, blue: 177/255)], startPoint: .leading, endPoint: .trailing)
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
                                        .fill(Color(red: 208/255, green: 33/255, blue: 188/255))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color(red: 208/255, green: 82/255, blue: 116/255), lineWidth: 3)
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
                                        .stroke(Color(red: 208/255, green: 82/255, blue: 116/255), lineWidth: 3)
                                        .frame(width: 35, height: 35)
                                    
                                    Circle()
                                        .fill(Color(red: 208/255, green: 33/255, blue: 188/255))
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
                                        .stroke(Color(red: 208/255, green: 82/255, blue: 116/255), lineWidth: 3)
                                        .frame(width: 35, height: 35)
                                    
                                    Circle()
                                        .fill(Color(red: 208/255, green: 33/255, blue: 188/255))
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
                                        Text("WIN: \(Int(gameModel.reward))")
                                            .Bold(size: 17, color: Color(red: 71/255, green: 13/255, blue: 84/255))
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
                                        .Bold(size: 12, color: Color(red: 71/255, green: 13/255, blue: 84/255))
                                        .offset(x: -15)
                                }
                            
                            ZStack {
                                Circle()
                                    .stroke(Color(red: 208/255, green: 82/255, blue: 116/255), lineWidth: 3)
                                
                                Circle()
                                    .fill(Color(red: 208/255, green: 33/255, blue: 188/255))
                                
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
                            .fill(Color(red: 242/255, green: 66/255, blue: 204/255).opacity(0.5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color(red: 248/255, green: 124/255, blue: 239/255), lineWidth: 7)
                                    .overlay {
                                        SpriteView(scene: ballGameModel.createGameScene(gameData: gameModel), options: [.allowsTransparency])
                                            .ignoresSafeArea()
                                    }
                            }
                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 800 : UIScreen.main.bounds.size.height > 800 ? 500 : UIScreen.main.bounds.size.height > 730 ? 450 : 435, height: UIScreen.main.bounds.size.height > 1000 ? 650 : UIScreen.main.bounds.size.height > 800 ? 400 : UIScreen.main.bounds.size.height > 730 ? 350 : 280)
                            .cornerRadius(24)
                        
                        Button(action: {
                            if gameModel.bet * gameModel.numberOfBets <= gameModel.balance {
                                                 gameModel.dropBalls()
                                             } else {
                                                 showAlert = true
                                             }
                        }) {
                            Rectangle()
                                .fill(Color(red: 253/255, green: 199/255, blue: 2/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 255/255, green: 222/255, blue: 30/255), lineWidth: 3)
                                        .overlay {
                                            Text("Drop ball!")
                                                .Bold(size: 14, color: Color(red: 71/255, green: 13/255, blue: 84/255))
                                        }
                                }
                                .frame(width: UIScreen.main.bounds.size.height > 800 ? 230 : 216, height: UIScreen.main.bounds.size.height > 800 ? 44 : 34)
                                .cornerRadius(16)
                        }
                        .offset(y: UIScreen.main.bounds.size.height > 440 ? 25 : 15)
                        .alert("Not enough balance", isPresented: $showAlert) {
                            Button("OK", role: .cancel) { }
                        }
                    }
                    
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(Color(red: 242/255, green: 66/255, blue: 204/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 241/255, green: 177/255, blue: 0/255), lineWidth: 4)
                                    .overlay {
                                        VStack(spacing: 15) {
                                            HStack(alignment: .bottom) {
                                                Button(action: {
                                                    gameModel.decreaseBet()
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
                                                                    Text("$\(gameModel.bet * gameModel.numberOfBets)")
                                                                        .Bold(size: 16, color: Color(red: 71/255, green: 13/255, blue: 84/255))
                                                                        .minimumScaleFactor(0.7)
                                                                }
                                                        }
                                                        .frame(width: UIScreen.main.bounds.size.height > 1000 ? 192 : UIScreen.main.bounds.size.height > 700 ? 92 : 92, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                        .cornerRadius(16)
                                                }
                                                
                                                Button(action: {
                                                    gameModel.increaseBet()
                                                }) {
                                                    ZStack {
                                                        Circle()
                                                            .stroke(.white, lineWidth: 3)
                                                            .frame(width: 39, height: 39)
                                                        
                                                        Circle()
                                                            .fill(Color(red: 132/255, green: 1/255, blue: 150/255))
                                                            .frame(width: 38, height: 38)
                                                        
                                                        Text("+")
                                                            .Bold(size: 26)
                                                            .offset(y: -1)
                                                    }
                                                }
                                            }
                                            .padding(.top, 5)
                                            
                                            VStack(spacing: 15) {
                                                HStack {
                                                    Button(action: {
                                                        gameModel.setBet(to: 250)
                                                    }) {
                                                        Rectangle()
                                                            .fill(LinearGradient(colors: [Color(red: 132/255, green: 1/255, blue: 150/255)], startPoint: .leading, endPoint: .trailing))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(Color(red: 163/255, green: 2/255, blue: 96/255), lineWidth: 5)
                                                                    .overlay {
                                                                        Text("250")
                                                                            .Bold(size: 16, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                                    }
                                                            }
                                                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 92 : UIScreen.main.bounds.size.height > 800 ? 72 : 52, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                            .cornerRadius(16)
                                                    }
                                                    
                                                    Button(action: {
                                                        gameModel.setBet(to: 500)
                                                    }) {
                                                        Rectangle()
                                                            .fill(LinearGradient(colors: [Color(red: 132/255, green: 1/255, blue: 150/255)], startPoint: .leading, endPoint: .trailing))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(Color(red: 163/255, green: 2/255, blue: 96/255), lineWidth: 5)
                                                                    .overlay {
                                                                        Text("500")
                                                                            .Bold(size: 16, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                                    }
                                                            }
                                                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 92 : UIScreen.main.bounds.size.height > 800 ? 72 : 52, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                            .cornerRadius(16)
                                                    }
                                                    
                                                    Button(action: {
                                                        gameModel.setBet(to: 1000)
                                                    }) {
                                                        Rectangle()
                                                            .fill(LinearGradient(colors: [Color(red: 132/255, green: 1/255, blue: 150/255)], startPoint: .leading, endPoint: .trailing))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(Color(red: 163/255, green: 2/255, blue: 96/255), lineWidth: 5)
                                                                    .overlay {
                                                                        Text("1000")
                                                                            .Bold(size: 16, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                                    }
                                                            }
                                                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 92 : UIScreen.main.bounds.size.height > 800 ? 72 : 52, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                            .cornerRadius(16)
                                                    }
                                                }
                                                
                                                VStack(spacing: 8) {
                                                    VStack(spacing: 5) {
                                                        Text("Balls")
                                                            .Bold(size: 14, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                        
                                                        HStack(spacing: 5) {
                                                            Button(action: {
                                                                gameModel.decreaseBalls()
                                                            }) {
                                                                Rectangle()
                                                                    .fill(Color(red: 245/255, green: 62/255, blue: 175/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 7)
                                                                            .stroke(.white, lineWidth: 2)
                                                                            .overlay {
                                                                                Text("-")
                                                                                    .Regular(size: 24)
                                                                                    .opacity(0.6)
                                                                            }
                                                                    }
                                                                    .frame(width: 29, height: 24)
                                                                    .cornerRadius(7)
                                                            }
                                                            
                                                            ForEach(0..<4, id: \.self) { index in
                                                                Rectangle()
                                                                    .fill((index + 1) == gameModel.numberOfBets ? Color(red: 170/255, green: 74/255, blue: 255/255) : Color(red: 245/255, green: 85/255, blue: 210/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 7)
                                                                            .stroke(.white, lineWidth: 2)
                                                                            .overlay {
                                                                                Text("\(index + 1)")
                                                                                    .Regular(size: 16)
                                                                            }
                                                                    }
                                                                    .frame(width: 26, height: 24)
                                                                    .cornerRadius(7)
                                                            }
                                                            
                                                            Button(action: {
                                                                gameModel.increaseBalls()
                                                            }) {
                                                                Rectangle()
                                                                    .fill(Color(red: 194/255, green: 93/255, blue: 180/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 7)
                                                                            .stroke(Color(red: 101/255, green: 158/255, blue: 147/255), lineWidth: 2)
                                                                            .overlay {
                                                                                Text("+")
                                                                                    .Regular(size: 24, color: Color(red: 124/255, green: 241/255, blue: 168/255))
                                                                                    .offset(y: -2)
                                                                            }
                                                                    }
                                                                    .frame(width: 29, height: 24)
                                                                    .cornerRadius(7)
                                                            }
                                                        }
                                                    }
                                                    
//                                                    VStack(spacing: 5) {
//                                                        Text("Lines")
//                                                            .Bold(size: 14, color: Color(red: 254/255, green: 223/255, blue: 33/255))
//                                                        
//                                                        HStack(spacing: 5) {
//                                                            Button(action: {
//                                                          
//                                                            }) {
//                                                                Rectangle()
//                                                                    .fill(Color(red: 245/255, green: 62/255, blue: 175/255))
//                                                                    .overlay {
//                                                                        RoundedRectangle(cornerRadius: 7)
//                                                                            .stroke(.white, lineWidth: 2)
//                                                                            .overlay {
//                                                                                Text("-")
//                                                                                    .Regular(size: 24)
//                                                                                    .opacity(0.6)
//                                                                            }
//                                                                    }
//                                                                    .frame(width: 29, height: 24)
//                                                                    .cornerRadius(7)
//                                                            }
//                                                            
//                                                            ForEach(5..<10, id: \.self) { index in
//                                                                Rectangle()
//                                                                    .fill(Color(red: 245/255, green: 85/255, blue: 210/255))
//                                                                    .overlay {
//                                                                        RoundedRectangle(cornerRadius: 7)
//                                                                            .stroke(.white, lineWidth: 2)
//                                                                            .overlay {
//                                                                                Text("\(index + 1)")
//                                                                                    .Regular(size: 16)
//                                                                            }
//                                                                    }
//                                                                    .frame(width: 26, height: 24)
//                                                                    .cornerRadius(7)
//                                                            }
//                                                            
//                                                            Button(action: {
//                                                                
//                                                            }) {
//                                                                Rectangle()
//                                                                    .fill(Color(red: 194/255, green: 93/255, blue: 180/255))
//                                                                    .overlay {
//                                                                        RoundedRectangle(cornerRadius: 7)
//                                                                            .stroke(Color(red: 101/255, green: 158/255, blue: 147/255), lineWidth: 2)
//                                                                            .overlay {
//                                                                                Text("+")
//                                                                                    .Regular(size: 24, color: Color(red: 124/255, green: 241/255, blue: 168/255))
//                                                                                    .offset(y: -2)
//                                                                            }
//                                                                    }
//                                                                    .frame(width: 29, height: 24)
//                                                                    .cornerRadius(7)
//                                                            }
//                                                        }
//                                                    }
                                                }
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                            }
                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 400 : UIScreen.main.bounds.size.height > 800 ? 290 : 238, height: UIScreen.main.bounds.size.height > 1000 ? 380 : UIScreen.main.bounds.size.height > 800 ? 320 : 242)
                            .cornerRadius(16)
                        
                        Button(action: {
                            gameModel.maxBet()
                        }) {
                            Rectangle()
                                .fill(Color(red: 253/255, green: 199/255, blue: 2/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 250/255, green: 222/255, blue: 30/255), lineWidth: 3)
                                        .overlay {
                                            Text("MAX BET")
                                                .Bold(size: 17, color: Color(red: 71/255, green: 13/255, blue: 84/255))
                                        }
                                }
                                .frame(width: UIScreen.main.bounds.size.height > 800 ? 220 : 206, height: UIScreen.main.bounds.size.height > 800 ? 40 : 30)
                                .cornerRadius(16)
                        }
                        .offset(y: 15)
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
        }
    }
}
#Preview {
    BallGameView()
}

import SwiftUI
import SpriteKit
import Combine

class GameData: ObservableObject {
    @Published var reward: Double = 0.0
    @Published var bet: Int = 50
    @Published var numberOfBets: Int = 1 {
        didSet {
            if numberOfBets < 1 { numberOfBets = 1 }
            if numberOfBets > 4 { numberOfBets = 4 }
        }
    }
    @Published var balance: Int = UserDefaults.standard.integer(forKey: "coin")
    @Published var isPlayTapped: Bool = false
    @Published var labels: [String] = ["0.5x", "1x", "1.5x", "2x", "3x", "5x", "3x", "2x", "1.5x"]
    
    var createBallPublisher = PassthroughSubject<Void, Never>()
    
    var formattedBalance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: balance)) ?? "\(balance)"
    }
    
    var formattedBetTotal: String {
        let total = bet * numberOfBets
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: total)) ?? "\(total)"
    }
    
    func decreaseBet() {
        if bet - 50 >= 50 {
            bet -= 50
        }
    }
    func increaseBet() {
        let newBet = bet + 50
        if newBet * numberOfBets <= balance {
            bet = newBet
        }
    }
    func setBet(to value: Int) {
        if value * numberOfBets <= balance {
            bet = value
        }
    }
    func maxBet() {
        let max = balance / numberOfBets
        bet = max - max % 50
        if bet < 50 { bet = 50 }
    }
    
    func decreaseBalls() {
        if numberOfBets > 1 {
            numberOfBets -= 1
            if bet * numberOfBets > balance {
                bet = balance / numberOfBets
                bet -= bet % 50
                if bet < 50 { bet = 50 }
            }
        }
    }
    func increaseBalls() {
        if numberOfBets < 4 {
            if bet * (numberOfBets + 1) <= balance {
                numberOfBets += 1
            }
        }
    }
    
    func dropBalls() {
        guard bet * numberOfBets <= balance else {
            return
        }
        balance -= bet * numberOfBets
        UserDefaults.standard.set(balance, forKey: "coin")
        reward = 0.0
        isPlayTapped = true
        createBallPublisher.send(())
    }
        func resetGame() {
        bet = 50
        numberOfBets = 1
        reward = 0
        isPlayTapped = false
    }
    
    // Добавить выигрыш после падения мячей
    func addWin(_ amount: Double) {
        reward += amount
        balance += Int(reward)
        UserDefaults.standard.set(balance, forKey: "coin")
    }
    
    func finishGame() {
        balance += Int(reward)
   
        reward = 0
        isPlayTapped = false
    }
}


class GameSpriteKit: SKScene, SKPhysicsContactDelegate {
    var game: GameData? {
        didSet {
            bindToGame()
        }
    }
    
    private func bindToGame() {
        cancellables.removeAll()
        game?.$numberOfBets
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.createInitialBalls()
            }
            .store(in: &cancellables)
    }
    
    let ballCategory: UInt32 = 0x1 << 0
    let obstacleCategory: UInt32 = 0x1 << 1
    let ticketCategory: UInt32 = 0x1 << 2
    
    var ballsInPlay: Int = 0
    var ballNodes: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        size = UIScreen.main.bounds.size
        backgroundColor = .clear
        
        createObstacles()
        createTickets()
        createInitialBalls()
        
        game?.createBallPublisher.sink { [weak self] in
            self?.launchBalls()
        }.store(in: &cancellables)
    }
    
    var cancellables = Set<AnyCancellable>()
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        for (index, ball) in ballNodes.enumerated().reversed() {
            if ball.position.y < 0 || ball.position.x < 0 || ball.position.x > size.width {
                ball.removeFromParent()
                ballNodes.remove(at: index)
                ballsInPlay -= 1
                createBall(atIndex: index)
            }
        }
    }
    
    func createObstacles() {
        let startRowCount = 2
        let numberOfRows = 7
        let obstacleSize = CGSize(width: UIScreen.main.bounds.size.height > 1000 ? 50 : UIScreen.main.bounds.size.height > 800 ? 50 : UIScreen.main.bounds.size.height > 730 ? 40 : 37, height: UIScreen.main.bounds.size.height > 1000 ? 50 : UIScreen.main.bounds.size.height > 800 ? 50 : UIScreen.main.bounds.size.height > 730 ? 35 : 25)
        let horizontalSpacing: CGFloat = 35
        
        for row in 0..<numberOfRows {
            let countInRow = startRowCount + row
            let totalWidth = CGFloat(countInRow) * (obstacleSize.width + horizontalSpacing) - horizontalSpacing
            let xOffset = (size.width - totalWidth) / 2 + obstacleSize.width / 2
            let yPosition = size.height / 1.2 - CGFloat(row) * (obstacleSize.height + (UIScreen.main.bounds.size.height > 1000 ? 50 : UIScreen.main.bounds.size.height > 800 ? 30 : UIScreen.main.bounds.size.height > 730 ? 35 : UIScreen.main.bounds.height > 430 ? 16 : 13))
            
            for col in 0..<countInRow {
                let obstacle = SKSpriteNode(imageNamed: "obstacle")
                obstacle.size = obstacleSize
                let xPosition = xOffset + CGFloat(col) * (obstacleSize.width + horizontalSpacing)
                obstacle.position = CGPoint(x: xPosition, y: yPosition)
                
                obstacle.physicsBody = SKPhysicsBody(circleOfRadius: obstacleSize.width / 2.0)
                obstacle.physicsBody?.isDynamic = false
                obstacle.physicsBody?.friction = 0.1
                obstacle.physicsBody?.restitution = 0.8
                obstacle.physicsBody?.categoryBitMask = obstacleCategory
                obstacle.physicsBody?.contactTestBitMask = ballCategory
                
                addChild(obstacle)
            }
        }
    }
    
    func createTickets() {
        guard let game = self.game else { return }
        let names = ["ticket3", "ticket3", "ticket2", "ticket1", "ticket1", "ticket1", "ticket2", "ticket3", "ticket3"]
        let labels = game.labels
        
        let count = names.count
        let ticketSize = CGSize(width: UIScreen.main.bounds.size.height > 1000 ? 80 : UIScreen.main.bounds.size.height > 800 ? 80 : UIScreen.main.bounds.size.height > 730 ? 70 : 55, height: UIScreen.main.bounds.size.height > 1000 ? 55 : UIScreen.main.bounds.size.height > 800 ? 50 : UIScreen.main.bounds.size.height > 730 ? 50 : 30)
        let horizontalSpacing: CGFloat = 10
        let totalWidth = CGFloat(count) * (ticketSize.width + horizontalSpacing) - horizontalSpacing
        let xOffset = (size.width - totalWidth) / 2 + ticketSize.width / 2
        let yPosition = size.height / 6
        
        for i in 0..<count {
            let ticket = SKSpriteNode(imageNamed: names[i])
            ticket.size = ticketSize
            let xPosition = xOffset + CGFloat(i) * (ticketSize.width + horizontalSpacing)
            ticket.position = CGPoint(x: xPosition, y: yPosition)
            
            ticket.physicsBody = SKPhysicsBody(rectangleOf: ticket.size)
            ticket.physicsBody?.isDynamic = false
            ticket.physicsBody?.categoryBitMask = ticketCategory
            ticket.physicsBody?.contactTestBitMask = ballCategory
            ticket.name = "ticket_\(i)"
            
            let label = SKLabelNode(text: labels[i])
            label.fontName = "Helvetica-Bold"
            label.fontSize = UIScreen.main.bounds.size.height > 1000 ? 20 : UIScreen.main.bounds.size.height > 800 ? 20 : UIScreen.main.bounds.size.height > 730 ? 18 : 12
            label.fontColor = .black
            label.verticalAlignmentMode = .center
            label.horizontalAlignmentMode = .center
            label.position = CGPoint.zero
            label.xScale = 1.4
            label.yScale = 1
            
            ticket.addChild(label)
            addChild(ticket)
        }
    }
    
    func createInitialBalls() {
        guard let game = game else { return }
        
        ballNodes.forEach { $0.removeFromParent() }
        ballNodes.removeAll()
        ballsInPlay = 0
        
        for _ in 0..<game.numberOfBets {
            let ball = SKSpriteNode(imageNamed: "ball")
            ball.size = CGSize(width: UIScreen.main.bounds.size.height > 1000 ? 45 : UIScreen.main.bounds.size.height > 800 ? 50 : UIScreen.main.bounds.size.height > 730 ? 35 : 30, height: UIScreen.main.bounds.size.height > 1000 ? 40 : UIScreen.main.bounds.size.height > 800 ? 50 : UIScreen.main.bounds.size.height > 730 ? 30 : 20)
            ball.position = CGPoint(x: size.width / 2,
                                    y: size.height / 1.07)
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 5)
            ball.physicsBody?.categoryBitMask = ballCategory
            ball.physicsBody?.contactTestBitMask = obstacleCategory | ticketCategory
            ball.physicsBody?.collisionBitMask = obstacleCategory | ticketCategory
            ball.physicsBody?.restitution = 0.4
            ball.physicsBody?.linearDamping = 0.5
            ball.physicsBody?.friction = 0.1
            ball.physicsBody?.isDynamic = true
            ball.physicsBody?.allowsRotation = false
            ball.physicsBody?.affectedByGravity = false
            
            addChild(ball)
            ballNodes.append(ball)
            ballsInPlay += 1
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let game = game else { return }
        var ticketNode: SKNode?
        var ballNode: SKNode?
        
        if contact.bodyA.categoryBitMask == ticketCategory {
            ticketNode = contact.bodyA.node
        }
        if contact.bodyB.categoryBitMask == ticketCategory {
            ticketNode = contact.bodyB.node
        }
        if contact.bodyA.categoryBitMask == ballCategory {
            ballNode = contact.bodyA.node
        }
        if contact.bodyB.categoryBitMask == ballCategory {
            ballNode = contact.bodyB.node
        }
        
        if let ticket = ticketNode as? SKSpriteNode,
           let label = ticket.children.first as? SKLabelNode,
           let multiplier = parseMultiplier(from: label.text),
           let ball = ballNode as? SKSpriteNode {
            
            let win = Double(game.bet) * multiplier
            game.addWin(win)
            
            ball.removeFromParent()
            if let index = ballNodes.firstIndex(of: ball) {
                ballNodes.remove(at: index)
            }
            ballsInPlay -= 1
            
            createBall(atIndex: 0)
        }
        
        checkBallsStopped()
    }

    func createBall(atIndex index: Int) {
        guard let game = game else { return }
        guard index < game.numberOfBets else { return }
        
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.size = CGSize(width: UIScreen.main.bounds.size.height > 1000 ? 45 : UIScreen.main.bounds.size.height > 800 ? 50 : UIScreen.main.bounds.size.height > 730 ? 35 : 30, height: UIScreen.main.bounds.size.height > 1000 ? 40 : UIScreen.main.bounds.size.height > 800 ? 50 : UIScreen.main.bounds.size.height > 730 ? 30 : 20)
        ball.position = CGPoint(x: size.width / 2 ,
                                y: size.height / 1.07)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 5)
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = obstacleCategory | ticketCategory
        ball.physicsBody?.collisionBitMask = obstacleCategory | ticketCategory
        ball.physicsBody?.restitution = 0.4
        ball.physicsBody?.linearDamping = 0.5
        ball.physicsBody?.friction = 0.1
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.affectedByGravity = false
        
        addChild(ball)
        ballNodes.append(ball)
        ballsInPlay += 1
    }

    func launchBalls() {
        for (i, ball) in ballNodes.enumerated() {
            ball.physicsBody?.affectedByGravity = true
            let baseImpulseX: CGFloat = 0.2
            let variation = CGFloat(i) - CGFloat(ballNodes.count - 1)/2
            
            let randomXImpulse = baseImpulseX * variation + CGFloat.random(in: -0.1...0.1)
            
            ball.physicsBody?.applyImpulse(CGVector(dx: randomXImpulse, dy: 0))
        }
    }

    private func parseMultiplier(from text: String?) -> Double? {
        guard let text = text?.lowercased().replacingOccurrences(of: "x", with: "") else { return nil }
        return Double(text)
    }
    
    private func checkBallsStopped() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self, let game = self.game else { return }
            let movingBalls = self.ballNodes.filter {
                guard let body = $0.physicsBody else { return false }
                return body.velocity.dx > 5 || body.velocity.dy > 5
            }
            if movingBalls.isEmpty && game.isPlayTapped {
                game.finishGame()
            }
        }
    }
}


