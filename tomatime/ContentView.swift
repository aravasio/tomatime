//
//  ContentView.swift
//  Tomatime
//
//  Created by Alejandro Ravasio on 31/05/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 1500
    @State private var timerRunning = false
    @State private var soundEffect = SoundEffect.systemSoundEffects.first!

    var body: some View {
        VStack {
            CircularProgressBar(timeRemaining: $timeRemaining, totalTime: 1500)
                .padding(20)

            HStack {
                Button(action: {
                    self.soundEffect.play()
                    timerRunning = !timerRunning
                }) {
                    Text(timerRunning ? "Pause" : "Start")
                }

                Button(action: {
                    self.timeRemaining = 1500
                    self.timerRunning = false
                    self.soundEffect.play()
                }) {
                    Text("Reset")
                }
            }
        }
        .onReceive(timer) { _ in
            if self.timerRunning && self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
