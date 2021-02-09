//
//  ContentView.swift
//  AudioRecorder
//
//  Created by Alexander Zwerner on 12/27/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var countDownTimer = CountDownTimer()
    @GestureState var isLongPress = false // will be true till tap hold
    
    var plusLongPress: some Gesture {
        LongPressGesture().sequenced(before:
              DragGesture(minimumDistance: 0, coordinateSpace:
              .local)).updating($isLongPress) { value, state, transaction in
                
                switch value {
                    case .second(true, nil):
                        state = true
                    default:
                        break
                }
              }
        }
    
    
    var body: some View {
        NavigationView {
            VStack {
                RecordingsList(audioRecorder: audioRecorder)
                ZStack{
                    Circle()
                        .strokeBorder(Color.black,lineWidth: 6)
                        .background(Circle().foregroundColor(Color.white))
                        .frame(width: 100, height: 100)
                        //.scaleEffect(tap ? 1.2 : 1)
                    Circle()
                        .trim(from: countDownTimer.counter / 10, to: 1)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.01176470588, green: 0.5843137255, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.6666666667, green: 0.7411764706, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 95, height: 95)
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                        .animation(Animation.easeIn.speed(0.15))
                        .animation(Animation.easeOut.speed(1.5))
                        .onChange(of: isLongPress, perform: { value in
                            if isLongPress == true {
                                audioRecorder.startRecording()
                                countDownTimer.start()
                            } else {
                                countDownTimer.stop()
                                countDownTimer.counter = 10
                                audioRecorder.stopRecording()
                            }
                        })
                }
                .offset(y: -40)
                .gesture(plusLongPress)
                
                .navigationBarTitle("Voice recorder")
                .navigationBarItems(trailing: EditButton())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioRecorder: AudioRecorder())
    }
}
