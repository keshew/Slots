import SwiftUI
import SpriteKit

struct Sector {
    let number: Int
    let color: String
}

struct SpinGameView: View {
    @StateObject var spinGameModel =  SpinGameViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showWinPopup = false
    @State var isSettings = false
    @State var isProfile = false
    @State var showAlert = false
    @ObservedObject private var soundManager = SoundManager.shared
    @State private var balance: Int = UserDefaults.standard.integer(forKey: "coin")
    @State private var bet: Int = 50
    @State private var reward: Int = 0
    
    @State private var selectedNumber: Int? = nil
    @State private var selectedColor: String? = nil
    
    @State private var wheelAngle: Double = 0
    @State private var isSpinning = false
    @State private var resultSector: Sector? = nil
    
    @State private var showSelectionAlert = false
      @State private var showBalanceAlert = false

      func spinWheel() {
          guard selectedNumber != nil || selectedColor != nil else {
              showSelectionAlert = true
              return
          }
          
          guard balance >= bet else {
              showBalanceAlert = true
              return
          }
          
          balance -= bet
          UserDefaults.standard.set(balance, forKey: "coin")
          
          guard !isSpinning else { return }
          isSpinning = true
          let rotations = Double(Int.random(in: 4...7))
          let randomStopAngle = Double.random(in: 0..<360)
          let targetAngle = wheelAngle + rotations * 360 + randomStopAngle

          withAnimation(.easeOut(duration: 3)) {
              wheelAngle = targetAngle
          }

          DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
              isSpinning = false
              let stopAngle = wheelAngle.truncatingRemainder(dividingBy: 360)
              resultSector = sectorForAngle(stopAngle)

              checkResult()
          }
      }

      func checkResult() {
          if let sector = resultSector {
              var won = false
              if selectedNumber == sector.number {
                  won = true
              } else if selectedColor == sector.color {
                  won = true
              }

              if won {
                  let winAmount = bet * 2
                  reward = winAmount
                  balance += winAmount
                  UserDefaults.standard.set(balance, forKey: "coin")
                  print("Вы выиграли! Выпало число \(sector.number), цвет: \(sector.color). Выигрыш: \(winAmount)")
              } else {
                  reward = 0
                  print("Вы проиграли. Выпало число \(sector.number), цвет: \(sector.color)")
              }
          }
      }
    
    func sectorForAngle(_ angle: Double) -> Sector {
        let normalizedAngle = angle.truncatingRemainder(dividingBy: 360)
        let adjustedAngle = (360 - normalizedAngle - 20).truncatingRemainder(dividingBy: 360)
        let index = Int(adjustedAngle / 18) % sectors.count
        
        return sectors[index]
    }
    
    let sectors: [Sector] = [
        Sector(number: 0, color: "green"),
        Sector(number: 8, color: "red"),
        Sector(number: 7, color: "black"),
        Sector(number: 3, color: "red"),
        Sector(number: 11, color: "black"),
        Sector(number: 1, color: "red"),
        Sector(number: 9, color: "black"),
        Sector(number: 5, color: "red"),
        Sector(number: 16, color: "black"),
        Sector(number: 14, color: "red"),
        Sector(number: 18, color: "black"),
        Sector(number: 2, color: "red"),
        Sector(number: 10, color: "black"),
        Sector(number: 13, color: "red"),
        Sector(number: 12, color: "black"),
        Sector(number: 4, color: "red"),
        Sector(number: 15, color: "black"),
        Sector(number: 17, color: "red"),
    ]

    var body: some View {
        ZStack {
            Image(.bg6)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [Color(red: 124/255, green: 62/255, blue: 249/255),
                                                       Color(red: 59/255, green: 41/255, blue: 227/255),
                                                       Color(red: 44/255, green: 20/255, blue: 222/255)], startPoint: .leading, endPoint: .trailing)
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
                                        .fill(Color(red: 34/255, green: 50/255, blue: 210/255))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color(red: 101/255, green: 101/255, blue: 153/255), lineWidth: 3)
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
                                        .stroke(Color(red: 101/255, green: 101/255, blue: 153/255), lineWidth: 3)
                                        .frame(width: 35, height: 35)
                                    
                                    Circle()
                                        .fill(Color(red: 34/255, green: 50/255, blue: 210/255))
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
                                        .stroke(Color(red: 101/255, green: 101/255, blue: 153/255), lineWidth: 3)
                                        .frame(width: 35, height: 35)
                                    
                                    Circle()
                                        .fill(Color(red: 34/255, green: 50/255, blue: 210/255))
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
                                        Text("WIN: \(reward)")
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
                                    Text("BALANCE \(balance)")
                                        .Bold(size: 12, color: Color(red: 71/255, green: 13/255, blue: 84/255))
                                        .offset(x: -15)
                                }
                            
                            ZStack {
                                Circle()
                                    .stroke(Color(red: 101/255, green: 101/255, blue: 153/255), lineWidth: 3)
                                
                                Circle()
                                    .fill(Color(red: 34/255, green: 50/255, blue: 210/255))
                                
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
                
                HStack(spacing: 40) {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(Color(red: 110/255, green: 182/255, blue: 221/255).opacity(0.6))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 110/255, green: 182/255, blue: 221/255), lineWidth: 4)
                                    .overlay {
                                        ZStack(alignment: .top) {
                                            Image(.wheel)
                                                .resizable()
                                                .frame(width: 200, height: 200)
                                                .rotationEffect(.degrees(wheelAngle))
                                            
                                            Image(.pin)
                                                .resizable()
                                                .frame(width: 10, height: 30)
                                        }
                                            .offset(y: -5)
                                    }
                            }
                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 400 : UIScreen.main.bounds.size.height > 800 ? 290 : 278, height: UIScreen.main.bounds.size.height > 1000 ? 380 : UIScreen.main.bounds.size.height > 800 ? 320 : 255)
                            .cornerRadius(16)
                        
                        Button(action: {
                            spinWheel()
                        }) {
                            Rectangle()
                                .fill(Color(red: 253/255, green: 199/255, blue: 2/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 250/255, green: 222/255, blue: 30/255), lineWidth: 3)
                                        .overlay {
                                            Text("Spin the wheel")
                                                .Bold(size: 15, color: Color(red: 71/255, green: 13/255, blue: 84/255))
                                        }
                                }
                                .frame(width: UIScreen.main.bounds.size.height > 800 ? 220 : 206, height: UIScreen.main.bounds.size.height > 800 ? 40 : 30)
                                .cornerRadius(16)
                        }
                        .offset(y: 15)
                    }
                    
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(Color(red: 110/255, green: 182/255, blue: 221/255).opacity(0.6))
                            .overlay {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color(red: 110/255, green: 182/255, blue: 221/255), lineWidth: 7)
                                    .overlay {
                                        VStack {
                                            NumberGridView()
                                            
                                            HStack(spacing: 30) {
                                                VStack(spacing: 15) {
                                                    HStack(alignment: .bottom) {
                                                        Button(action: {
                                                            if bet - 50 >= 0 {
                                                                               bet -= 50
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
                                                                            Text("$\(bet)")
                                                                                .Bold(size: 16, color: Color(red: 71/255, green: 13/255, blue: 84/255))
                                                                                .minimumScaleFactor(0.7)
                                                                        }
                                                                }
                                                                .frame(width: UIScreen.main.bounds.size.height > 1000 ? 192 : UIScreen.main.bounds.size.height > 700 ? 92 : 92, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 38)
                                                                .cornerRadius(16)
                                                        }
                                                        
                                                        Button(action: {
                                                            if bet + 50 <= balance {
                                                                               bet += 50
                                                                           }
                                                        }) {
                                                            ZStack {
                                                                Circle()
                                                                    .stroke(.white, lineWidth: 3)
                                                                    .frame(width: 39, height: 39)
                                                                
                                                                Circle()
                                                                    .fill(Color(red: 62/255, green: 39/255, blue: 170/255))
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
                                                                if balance >= 250 {
                                                                    bet = 250
                                                                }
                                                            }) {
                                                                Rectangle()
                                                                    .fill(LinearGradient(colors: [Color(red: 0/255, green: 25/255, blue: 135/255)], startPoint: .leading, endPoint: .trailing))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 16)
                                                                            .stroke(Color.white, lineWidth: 5)
                                                                            .overlay {
                                                                                Text("250")
                                                                                    .Bold(size: 16, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                                            }
                                                                    }
                                                                    .frame(width: UIScreen.main.bounds.size.height > 1000 ? 92 : UIScreen.main.bounds.size.height > 800 ? 72 : 52, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                                    .cornerRadius(16)
                                                            }
                                                            
                                                            Button(action: {
                                                                if balance >= 500 {
                                                                    bet = 500
                                                                }
                                                            }) {
                                                                Rectangle()
                                                                    .fill(LinearGradient(colors: [Color(red: 0/255, green: 25/255, blue: 135/255)], startPoint: .leading, endPoint: .trailing))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 16)
                                                                            .stroke(Color.white, lineWidth: 5)
                                                                            .overlay {
                                                                                Text("500")
                                                                                    .Bold(size: 16, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                                            }
                                                                    }
                                                                    .frame(width: UIScreen.main.bounds.size.height > 1000 ? 92 : UIScreen.main.bounds.size.height > 800 ? 72 : 52, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                                    .cornerRadius(16)
                                                            }
                                                            
                                                            Button(action: {
                                                                if balance >= 1000 {
                                                                    bet = 1000
                                                                }
                                                            }) {
                                                                Rectangle()
                                                                    .fill(LinearGradient(colors: [Color(red: 0/255, green: 25/255, blue: 135/255)], startPoint: .leading, endPoint: .trailing))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 16)
                                                                            .stroke(Color.white, lineWidth: 5)
                                                                            .overlay {
                                                                                Text("1000")
                                                                                    .Bold(size: 15, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                                            }
                                                                    }
                                                                    .frame(width: UIScreen.main.bounds.size.height > 1000 ? 92 : UIScreen.main.bounds.size.height > 800 ? 72 : 52, height: UIScreen.main.bounds.size.height > 1000 ? 48 : UIScreen.main.bounds.size.height > 800 ? 38 : 28)
                                                                    .cornerRadius(16)
                                                            }
                                                        }
                                                    }
                                                    
                                                    Spacer()
                                                }
                                                
                                                VStack {
                                                    Text("COLOR")
                                                        .Bold(size: 18, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                                    
                                                    HStack(spacing: 0) {
                                                        Button(action: {
                                                            selectedColor = selectedColor == "red" ? nil : "red"
                                                                            selectedNumber = nil
                                                        }) {
                                                            Rectangle()
                                                                .fill(Color(red: 218/255, green: 22/255, blue: 23/255))
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 0)
                                                                        .stroke(selectedColor == "red" ? Color(red: 62/255, green: 39/255, blue: 170/255) : Color.white, lineWidth: 2)
                                                                        .overlay {
                                                                            Text("Red")
                                                                                .Bold(size: 24)
                                                                        }
                                                                }
                                                                .frame(width: 100, height: 60)
                                                        }
                                                        
                                                        Button(action: {
                                                            selectedColor = selectedColor == "black" ? nil : "black"
                                                                            selectedNumber = nil
                                                        }) {
                                                            Rectangle()
                                                                .fill(Color(red: 42/255, green: 44/255, blue: 45/255))
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 0)
                                                                        .stroke(selectedColor == "black" ? Color(red: 62/255, green: 39/255, blue: 170/255) : Color.white, lineWidth: 2)
                                                                        .overlay {
                                                                            Text("Black")
                                                                                .Bold(size: 24)
                                                                        }
                                                                }
                                                                .frame(width: 100, height: 60)
                                                        }
                                                    }
                                                    .padding(.bottom, 25)
                                                }
                                            }
                                        }
                                    }
                            }
                            .frame(width: UIScreen.main.bounds.size.height > 1000 ? 600 : UIScreen.main.bounds.size.height > 800 ? 500 : 465, height: UIScreen.main.bounds.size.height > 1000 ? 550 : UIScreen.main.bounds.size.height > 800 ? 400 : 310)
                            .cornerRadius(24)
                    }
                }
                
                Spacer()
            }
            .alert("Pick the color or number!", isPresented: $showSelectionAlert) {
                     Button("ОК", role: .cancel) {}
                 }
                 .alert("Not enough coins to spin!", isPresented: $showBalanceAlert) {
                     Button("ОК", role: .cancel) {}
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
    SpinGameView()
}

struct NumberGridView: View {
    let numbers = Array(0..<21)
    
    @State private var selectedNumber: Int? = nil
    @State private var selectedColor: String? = nil
    
    func cellColor(for number: Int) -> Color {
        if number == 0 {
            return Color(red: 141/255, green: 218/255, blue: 52/255)
        } else if [1,3,5,7,9,11,13,15,17,19].contains(number) {
            return Color(red: 218/255, green: 22/255, blue: 23/255)
        } else {
            return Color(red: 42/255, green: 44/255, blue: 45/255)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button(action: {
                    selectedNumber = 0
                    selectedColor = nil
                    print("Tapped 0")
                }) {
                    Rectangle()
                        .fill(cellColor(for: 0))
                        .overlay {
                            Text("0")
                                .Bold(size: 25)
                        }
                        .frame(width: 100, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(selectedNumber == 0 ? Color.blue : Color.clear, lineWidth: 1)
                        )
                }
                
                ForEach(1..<6) { number in
                    Button(action: {
                        selectedNumber = number
                        selectedColor = nil
                        print("Tapped \(number)")
                    }) {
                        Rectangle()
                            .fill(cellColor(for: number))
                            .overlay {
                                Text("\(number)")
                                    .Bold(size: 25)
                            }
                            .frame(width: 50, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(selectedNumber == number ? Color.blue : Color.clear, lineWidth: 1)
                            )
                    }
                }
            }
            
            HStack(spacing: 0) {
                ForEach(6..<13) { number in
                    Button(action: {
                        selectedNumber = number
                        selectedColor = nil
                        print("Tapped \(number)")
                    }) {
                        Rectangle()
                            .fill(cellColor(for: number))
                            .overlay {
                                Text("\(number)")
                                    .Bold(size: 25)
                            }
                            .frame(width: 50, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(selectedNumber == number ? Color.blue : Color.clear, lineWidth: 1)
                            )
                    }
                }
            }
            
            HStack(spacing: 0) {
                ForEach(13..<20) { number in
                    Button(action: {
                        selectedNumber = number
                        selectedColor = nil
                        print("Tapped \(number)")
                    }) {
                        Rectangle()
                            .fill(cellColor(for: number))
                            .overlay {
                                Text("\(number)")
                                    .Bold(size: 25)
                            }
                            .frame(width: 50, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(selectedNumber == number ? Color.blue : Color.clear, lineWidth: 1)
                            )
                    }
                }
            }
        }
        .border(Color.white, width: 3)
        .padding()
        .frame(maxWidth: 400)
    }
}


