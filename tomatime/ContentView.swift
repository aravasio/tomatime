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

    var body: some View {
        VStack {
            CircularProgressBar(timeRemaining: $timeRemaining, totalTime: 1500)
                .padding(20)

            HStack {
                Button(action: {
                    self.timerRunning = true
                }) {
                    Text("Start")
                }

                Button(action: {
                    self.timerRunning = false
                }) {
                    Text("Pause")
                }

                Button(action: {
                    self.timeRemaining = 1500
                    self.timerRunning = false
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

struct CircularProgressBar: View {
    @Binding var timeRemaining: Int
    let totalTime: Int

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(Color.gray)

            Circle()
                .trim(from: 0.0, to: 1 - CGFloat(timeRemaining) / CGFloat(totalTime))
                .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .butt))
                .rotationEffect(Angle(degrees: 270.0))

            Circle()
                .trim(from: 1 - CGFloat(timeRemaining) / CGFloat(totalTime), to: 1.0)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .butt))
                .rotationEffect(Angle(degrees: 270.0))

            Text(String(format: "%02d:%02d", timeRemaining / 60, timeRemaining % 60))
                .font(.largeTitle)
        }
        .frame(width: 200, height: 200)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
