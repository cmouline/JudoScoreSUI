//
//  VictoryView.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 15/10/2024.
//

import SwiftUI

struct VictoryView: View {
    
    @Environment(Fight.self) private var fight

    var body: some View {
        Text("\(fight.victoryData?.displayVictoryText() ?? "No victory data")")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.custom("LemonMilk", size: 32))
            .background(.black)
            .foregroundStyle(fight.victoryData?.winnerColor ?? .primary)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(fight.victoryData?.winnerColor ?? .primary, lineWidth: 10)
            )
    }
}

#Preview {
    @Previewable var fight = Fight(fighter1: Fighter(color: .red),
                                   fighter2: Fighter(color: .white))
    VictoryView()
        .environment(fight)
}
