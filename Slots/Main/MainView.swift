import SwiftUI

struct MainView: View {
    @StateObject var mainModel =  MainViewModel()
    @State var currentIndex = 0
    @State var isGame = false
    @State var isSettings = false
    @State var isProfile = false
    
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
    
    var body: some View {
        ZStack {
            Image(selectedBG)
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
//                .offset(y: 10)
            
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
                                
                            }) {
                                ZStack {
                                    Circle()
                                        .stroke(overlaySettingsBtn, lineWidth: 3)
                                        .frame(width: 35, height: 35)
                                    
                                    Circle()
                                        .fill(backSettingsBtn)
                                        .frame(width: 35, height: 35)

                                    Text("Privacy\nPolicy")
                                        .Bold(size: 8, color: Color(red: 254/255, green: 207/255, blue: 14/255))
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
                            
//                            Button(action: {
//                                
//                            }) {
//                                ZStack {
//                                    Circle()
//                                        .stroke(overlaySettingsBtn, lineWidth: 3)
//                                        .frame(width: 35, height: 35)
//                                    
//                                    Circle()
//                                        .fill(backSettingsBtn)
//                                        .frame(width: 35, height: 35)
//                                    
//                                    Image(.sound)
//                                        .resizable()
//                                        .frame(width: 16, height: 16)
//                                }
//                            }
                            
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
                        
                        Image(.chooseGameLabel)
                            .resizable()
                            .frame(width: 268, height: 75)
                            .padding(.trailing)
                        
                        Spacer()
                        
                        ZStack(alignment: .trailing) {
                            Image(.yellowBack)
                                .resizable()
                                .frame(width: 150, height: 38)
                                .overlay {
                                    Text("BALANCE \(mainModel.coins)")
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
                    .padding(.horizontal, UIScreen.main.bounds.size.height > 700 ? 70 : 10)
                }
                .offset(y: UIScreen.main.bounds.size.height > 700 ? -20 : UIScreen.main.bounds.size.height > 430 ? 65 : 55)
                
                Spacer()
                
                VStack(spacing: UIScreen.main.bounds.size.height > 800 ? 55 : UIScreen.main.bounds.height > 430 ? 25 : 15) {
                    Rectangle()
                        .fill(Color(red: 253/255, green: 199/255, blue: 2/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 255/255, green: 222/255, blue: 30/255), lineWidth: 3)
                                .overlay {
                                    Text("Selected: \(selected)")
                                        .Bold(size: UIScreen.main.bounds.size.height > 800 ? 24 : 17, color: fontColor)
                                }
                        }
                        .frame(width: UIScreen.main.bounds.size.height > 700 ? 300 : 225, height:  UIScreen.main.bounds.size.height > 800 ? 58 : 38)
                        .cornerRadius(16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    currentIndex = 0
                                }
                            }) {
                                ZStack {
                                    Image(.game1)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: UIScreen.main.bounds.size.height > 700 ? 300 : 163, height: UIScreen.main.bounds.size.height > 700 ? 300 : 172)
                                    
                                    if currentIndex == 0 {
                                        Image(.selected1)
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.size.height > 700 ? 300 : 163, height: UIScreen.main.bounds.size.height > 700 ? 300 : 172)
                                            .offset(y: -10)
                                    }
                                }
                            }
                            
                            Button(action: {
                                withAnimation {
                                    currentIndex = 1
                                }
                            }) {
                                ZStack {
                                    Image(.game2)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: UIScreen.main.bounds.size.height > 700 ? 300 : 163, height: UIScreen.main.bounds.size.height > 700 ? 300 : 172)
                                    
                                    if currentIndex == 1 {
                                        Image(.selected2)
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.size.height > 700 ? 300 : 163, height: UIScreen.main.bounds.size.height > 700 ? 300 : 172)
                                            .offset(y: -10)
                                    }
                                }
                            }
                            
                            Button(action: {
                                withAnimation {
                                    currentIndex = 2
                                }
                            }) {
                                ZStack {
                                    Image(.game3)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: UIScreen.main.bounds.size.height > 700 ? 300 : 163, height: UIScreen.main.bounds.size.height > 700 ? 300 : 172)
                                    
                                    if currentIndex == 2 {
                                        Image(.selected3)
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.size.height > 700 ? 300 : 163, height: UIScreen.main.bounds.size.height > 700 ? 300 : 172)
                                            .offset(y: -10)
                                    }
                                }
                            }
                            
                            Button(action: {
                                withAnimation {
                                    currentIndex = 3
                                }
                            }) {
                                ZStack {
                                    Image(.game4)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: UIScreen.main.bounds.size.height > 700 ? 300 : 163, height: UIScreen.main.bounds.size.height > 700 ? 300 : 172)
                                    
                                    if currentIndex == 3 {
                                        Image(.selected4)
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.size.height > 700 ? 300 : 163, height: UIScreen.main.bounds.size.height > 700 ? 300 : 172)
                                            .offset(y: -10)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, UIScreen.main.bounds.size.height > 1000 ? 130 : 60)
                    }
                    
                    Button(action: {
                        isGame = true
                    }) {
                        Rectangle()
                            .fill(Color(red: 253/255, green: 199/255, blue: 2/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 255/255, green: 222/255, blue: 30/255), lineWidth: 3)
                                    .overlay {
                                        HStack {
                                            Image(systemName: "play")
                                                .foregroundStyle(fontColor)
                                                .font(.system(size: UIScreen.main.bounds.size.height > 800 ? 24 : 16))
                                            Text("PLAY")
                                                .Bold(size: UIScreen.main.bounds.size.height > 800 ? 22 : 16, color: fontColor)
                                        }
                                    }
                            }
                            .frame(width: UIScreen.main.bounds.size.height > 800 ? 200 : 135, height: UIScreen.main.bounds.size.height > 800 ? 49 : 39)
                            .cornerRadius(16)
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
        .fullScreenCover(isPresented: $isGame) {
            GameView(currentIndex: $currentIndex)
        }
    }
}

#Preview {
    MainView()
}

