//
//  Untitled.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 04/10/2024.
//

import SwiftUI

struct PointButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50, height: 70)
            .background { LinearGradient(colors: [.black, .gray.opacity(0.3)], startPoint: .top, endPoint: .bottom) }
            .font(.custom("LemonMilk", size: 68))
    }
}
