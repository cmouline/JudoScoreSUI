//
//  TopBarView.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 03/10/2024.
//

import SwiftUI

struct TopBarView: View {
    
    @Environment(Fight.self) private var fight

    var body: some View {
        
        HStack {
            
            Button(action: {
                // go to menuView
            }, label: {
                Image(systemName: "line.3.horizontal")
            })
            
            Text("GS")
                .hidden(fight.victoryData?.victory != .equal)
                .font(.custom("LemonMilk", size: 24))
                .foregroundStyle(.jSyellow)
            
            Spacer()
            
            TimerView()
            
            Spacer()
            
            Text("\(fight.osaekomiTimerValue)")
                .frame(width: 80)
                .hidden(fight.osaekomiTimerValue == 0)
                .font(.custom("LemonMilk", size: 50))
                .foregroundStyle(fight.selectedFighter == nil ? .purple : fight.selectedFighter!.color.primary)
            
            Button(action: {
                fight.setWinner()
            }, label: {
                Image(systemName: "trophy.fill")
            })
            .disabled(!fight.isVictoryPossible)
            .foregroundStyle(fight.isVictoryPossible ? .green : .gray)
            
            Button(action: {
                fight.resetFight()
            }, label: {
                Image(systemName: "arrow.counterclockwise")
            })
            
        }
        .font(.system(size: 36))
        .foregroundStyle(.gray)
    }
}

#Preview {
    @Previewable var fight = Fight(fighter1: Fighter(color: .red),
                                   fighter2: Fighter(color: .white))
    TopBarView()
        .environment(fight)
}
