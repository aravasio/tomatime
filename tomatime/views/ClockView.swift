//
//  ClockView.swift
//  Tomatime
//
//  Created by Alejandro Ravasio on 31/05/2023.
//

import SwiftUI

struct CircularProgressBar: View {
    
    // MARK: - Properties
    @Binding var timeRemaining: Int
    let totalTime: Int
    
    private var elapsedTimeRatio: CGFloat {
        return 1 - CGFloat(timeRemaining) / CGFloat(totalTime)
    }
    
    private var remainingTimeText: String {
        String(format: "%02d:%02d", timeRemaining / 60, timeRemaining % 60)
    }
    
    private let WIDTH: CGFloat = 200
    private let HEIGHT: CGFloat = 200
    
    private var progressBarSize: CGSize {
        CGSize(width: WIDTH, height: HEIGHT)
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            greenView()
            redView()
            blueView()
            whiteView()
            Text(remainingTimeText)
                .font(.largeTitle)
        }
        .frame(width: WIDTH, height: HEIGHT)
    }
    
    @ViewBuilder
    private func redView() -> some View {
        Circle()
            .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .rotationEffect(Angle(degrees: 270.0))
            .opacity(1.0 - elapsedTimeRatio)
    }
    
    @ViewBuilder
    private func greenView() -> some View {
        Circle()
            .foregroundColor(.green)
            .opacity(elapsedTimeRatio)
            .padding(11)
    }
    
    @ViewBuilder
    private func blueView() -> some View {
        Circle()
            .trim(from: 0.0, to: elapsedTimeRatio)
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .rotationEffect(Angle(degrees: 270.0))
    }
    
    @ViewBuilder
    private func whiteView() -> some View {
        Circle()
            .stroke(Color.white, lineWidth: 2)
            .frame(width: 20, height: 20)
            .offset(
                calculateWhiteCircleOffset(progress: elapsedTimeRatio, circleSize: progressBarSize)
            )
            .rotationEffect(Angle(degrees: 270.0))
    }
    
    private func calculateWhiteCircleOffset(progress: CGFloat, circleSize: CGSize) -> CGSize {
        let radius = min(circleSize.width, circleSize.height) / 2
        let angle = Angle(degrees: 360 * Double(progress))
        let x = CGFloat(cos(angle.radians)) * radius
        let y = CGFloat(sin(angle.radians)) * radius
        return CGSize(width: x, height: y)
    }
    
}
