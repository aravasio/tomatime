//
//  TomatimeApp.swift
//  Tomatime
//
//  Created by Alejandro Ravasio on 31/05/2023.
//

import SwiftUI

@main
struct TomatimeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear {
                _ = SoundEffect.systemSoundEffects
            }
        }
    }
}
