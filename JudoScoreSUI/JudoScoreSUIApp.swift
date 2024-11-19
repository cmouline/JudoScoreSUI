//
//  JudoScoreSUIApp.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 30/09/2024.
//

import SwiftUI

@main
struct JudoScoreSUIApp: App {
    var body: some Scene {
        WindowGroup {
            BoardView()
                .preferredColorScheme(.dark)
        }
    }
}
