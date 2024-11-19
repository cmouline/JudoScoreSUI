//
//  PenaltyView.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 10/10/2024.
//

import SwiftUI

struct PenaltyView: View {
    var isTilted: Bool = false
    var color: Color = .jSyellow
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .stroke(.black, lineWidth: 5)
            .rotationEffect(isTilted ? .degrees(15.0) : .degrees(0.0),
                            anchor: .bottomTrailing)
            .frame(width: 50, height: 70)
    }
}

#Preview {
    HStack(spacing: 50) {
        PenaltyView()
        PenaltyView(isTilted: true)
        PenaltyView(color: .jSred)
    }
}
