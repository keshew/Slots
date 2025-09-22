import SwiftUI

struct SettingsView: View {
    @StateObject var settingsModel =  SettingsViewModel()
    @State var music: Float = 0
    @State var sound: Float = 0
    @State var isAudioOn = false
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            
            VStack {
                ZStack(alignment: .bottom) {
                    ZStack(alignment: .topTrailing) {
                        Rectangle()
                            .fill(Color(red: 10/255, green: 86/255, blue: 44/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 241/255, green: 177/255, blue: 0/255), lineWidth: 4)
                                    .overlay {
                                        VStack(spacing: 15) {
                                            HStack {
                                                Image(.settings)
                                                    .resizable()
                                                    .frame(width: 28, height: 28)
                                                    .padding(.trailing, 40)
                                                
                                                Text("SETTINGS")
                                                    .Bold(size: 30, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                    .padding(.trailing, 40)
                                            }
                                            
                                            Spacer()
                                            
                                            VStack(spacing: 15) {
                                                HStack {
                                                    Image(.audioSettings)
                                                        .resizable()
                                                        .frame(width: 24, height: 24)
                                                    
                                                    Text("Audio Settings")
                                                        .Bold(size: 20, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                    
                                                    Spacer()
                                                }
                                                
                                                HStack {
                                                    Text("Master Sound")
                                                        .Regular(size: 16, color: Color(red: 255/255, green: 240/255, blue: 133/255))
                                                    
                                                    Spacer()
                                                    
                                                    Button(action: {
                                                        isAudioOn.toggle()
                                                    }) {
                                                        Image(isAudioOn ? .audioOn : .audioOff)
                                                            .resizable()
                                                            .frame(width: 40, height: 36)
                                                    }
                                                }
                                                
                                                VStack {
                                                    HStack {
                                                        Text("Music Volume")
                                                            .Regular(size: 16, color: Color(red: 255/255, green: 240/255, blue: 133/255))
                                                        
                                                        Spacer()
                                                        
                                                        Text("\(Int(music * 100))%")
                                                            .Bold(size: 16, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                    }
                                                    
                                                    CustomSlider(value: $music,
                                                                 range: 0...1,
                                                                 sizeSlider: 240,
                                                                 color: Color(red: 231/255, green: 42/255, blue: 228/255))
                                                    .disabled(!isAudioOn)
                                                }
                                                
                                                VStack {
                                                    HStack {
                                                        Text("Effects Volume")
                                                            .Regular(size: 16, color: Color(red: 255/255, green: 240/255, blue: 133/255))
                                                        
                                                        Spacer()
                                                        
                                                        Text("\(Int(sound * 100))%")
                                                            .Bold(size: 16, color: Color(red: 254/255, green: 223/255, blue: 33/255))
                                                    }
                                                    
                                                    CustomSlider(value: $sound,
                                                                 range: 0...1,
                                                                 sizeSlider: 240,
                                                                 color: Color(red: 231/255, green: 42/255, blue: 228/255))
                                                    .disabled(!isAudioOn)
                                                }
                                            }
                                            .padding(.horizontal, 40)
                                            
                                            Spacer()
                                        }
                                        .padding(.vertical, 25)
                                    }
                            }
                            .frame(width: 539, height: 323)
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
                    
                    Button(action: {
                        var musicToSave = music
                        var soundToSave = sound

                        if !isAudioOn {
                            musicToSave = 0
                            soundToSave = 0
                        }

                        UserDefaults.standard.set(isAudioOn, forKey: "isAudioOn")
                        UserDefaults.standard.set(musicToSave, forKey: "musicVolume")
                        UserDefaults.standard.set(soundToSave, forKey: "soundVolume")

                        SoundManager.shared.isMusicEnabled = isAudioOn
                        SoundManager.shared.isSoundEnabled = isAudioOn
                        SoundManager.shared.backgroundVolume = musicToSave
                        SoundManager.shared.soundEffectVolume = soundToSave

                        if isAudioOn {
                            SoundManager.shared.playBackgroundMusic()
                        } else {
                            SoundManager.shared.stopBackgroundMusic()
                            SoundManager.shared.stopWheelMusic()
                            SoundManager.shared.stopSlot1()
                            SoundManager.shared.stopSlot2()
                            SoundManager.shared.stopSlot3()
                            SoundManager.shared.stopSlot4()
                        }
                    }) {
                        Rectangle()
                            .fill(Color(red: 10/255, green: 86/255, blue: 44/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 255/255, green: 222/255, blue: 30/255), lineWidth: 3)
                                    .overlay {
                                        Text("Save")
                                            .Bold(size: 14, color: Color(red: 255/255, green: 222/255, blue: 30/255))
                                    }
                            }
                            .frame(width: 116, height: 34)
                            .cornerRadius(16)
                    }
                    .offset(y: 25)
                }
            }
        }
        .onChange(of: isAudioOn) { newValue in
            if !newValue {
                music = 0
                sound = 0
            }
        }
        .onAppear {
            isAudioOn = UserDefaults.standard.bool(forKey: "isAudioOn")
            if isAudioOn {
                music = UserDefaults.standard.float(forKey: "musicVolume")
                sound = UserDefaults.standard.float(forKey: "soundVolume")
            } else {
                music = 0
                sound = 0
            }
        }
    }
}

#Preview {
    SettingsView(isShow: .constant(false))
}

struct CustomSlider: View {
    @Binding var value: Float
    let range: ClosedRange<Float>
    let thumbSize: CGFloat = 15
    let trackHeight: CGFloat = 17
    let sizeSlider: CGFloat
    var color: Color = Color(red: 101/255, green: 255/255, blue: 218/255)
    var image: String = "sliderPinGirl"

    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 254/255, green: 223/255, blue: 33/255), lineWidth: 2)
                    }
                    .frame(height: trackHeight)
                    .cornerRadius(8)
                
                Rectangle()
                    .fill(LinearGradient(colors: [Color(red: 138/255, green: 234/255, blue: 64/255),
                                                  Color(red: 107/255, green: 246/255, blue: 160/255)], startPoint: .leading, endPoint: .trailing))
                    .frame(width: max(0, CGFloat(normalizedValue) * geometry.size.width - 4), height: 12)
                    .cornerRadius(8)
                    .padding(.horizontal, 2)
                
                Circle()
                    .fill(.white)
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: CGFloat(normalizedValue) * (geometry.size.width - thumbSize))
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                updateValue(with: gesture.location.x, in: geometry.size.width)
                            }
                    )
            }
        }
        .frame(height: thumbSize)
    }
    
    private var normalizedValue: Float {
        return (value - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
    
    private func updateValue(with locationX: CGFloat, in totalWidth: CGFloat) {
        let newValue = Float((locationX / totalWidth)) * (range.upperBound - range.lowerBound) + range.lowerBound
        value = min(max(newValue, range.lowerBound), range.upperBound)
    }
}
