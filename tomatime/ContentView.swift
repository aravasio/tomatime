//
//  ContentView.swift
//  Tomatime
//
//  Created by Alejandro Ravasio on 31/05/2023.
//

import SwiftUI

enum IterationState {
    case working
    case resting
    
    var timerLength: Int {
        switch self {
        case .working:
            return 1500
        case .resting:
            return 300
        }
    }
    
    func nextState() -> IterationState {
        switch self {
        case .resting: return .working
        case .working: return .resting
        }
    }
}

struct ContentView: View {
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 1500 {
        didSet {
            if timeRemaining == 0 {
                iterationState = iterationState.nextState()
            }
        }
    }
    @State private var isTimerRunning = false
    @State private var soundEffect = SoundEffect.systemSoundEffects.first!
    @State private var iterationState: IterationState = .working {
        didSet {
            timeRemaining = iterationState.timerLength
        }
    }
    
    var body: some View {
        VStack {
            CircularProgressBar(timeRemaining: $timeRemaining, totalTime: iterationState.timerLength)
                .padding(20)
            
            buttonsView()
        }
        .onReceive(timer) { _ in
            if self.isTimerRunning && self.timeRemaining > 0 {
//                self.timeRemaining -= 1
                if iterationState == .working {
                    self.timeRemaining -= 150
                } else {
                    self.timeRemaining -= 10
                }
            }
        }
    }
    
    @ViewBuilder
    func buttonsView() -> some View {
        HStack {
            Button(action: {
                self.soundEffect.play()
                isTimerRunning = !isTimerRunning
            }) {
                Text(isTimerRunning ? "Pause" : "Start")
            }
            
            Button(action: {
                iterationState = .working
                self.isTimerRunning = false
                self.soundEffect.play()
            }) {
                Text("Reset")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
