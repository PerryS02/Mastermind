//
//  MastermindApp.swift
//  Mastermind
//
//  Created by Perry Sykes on 2/13/21.
//

import SwiftUI

@main
struct MastermindApp: App {
    var body: some Scene {
        WindowGroup {
            let game = MastermindGame()
            ContentView(viewModel: game)
        }
    }
}
