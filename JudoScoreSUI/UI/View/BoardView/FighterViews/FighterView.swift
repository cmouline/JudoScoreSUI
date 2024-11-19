//
//  FighterView.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 03/10/2024.
//

import SwiftUI

struct FighterView: View {
    
    @Bindable var fighter: Fighter

    var body: some View {
        
        HStack {
            
            TextField("", text: $fighter.name, prompt: Text(fighter.color.rawValue).foregroundStyle(Color.black.opacity(0.1)))
                .font(.custom("LemonMilk", size: 38))
                .frame(width: 300, height: 75)
                .background(fighter.color.primary)
                .foregroundStyle(Color.black.opacity(0.3))
                .clipShape(.rect(cornerRadius: 5))
                .onChange(of: fighter.name) { oldValue, newValue in
                    fighter.name = newValue
                }
            
            ZStack {
                
                PenaltyView(color: fighter.isHansokumake ? .jSred : .jSyellow)
                    .hidden(fighter.shido == 0 && !fighter.isHansokumake)
                
                PenaltyView(isTilted: true)
                    .offset(x: 15, y: 0)
                    .hidden(fighter.shido != 2 || fighter.isHansokumake)
                
            }
            
            Spacer()

            DoubleTapButton(tapAction: {
                
                fighter.isIppon = true
                
            }, doubleTapAction: {
                
                fighter.isIppon = false
                
            }, title: fighter.ipponString)
            .buttonStyle(PointButtonStyle())

            DoubleTapButton(tapAction: {
                
                fighter.addWazaari()
                
            }, doubleTapAction: {
                
                fighter.removeWazaari()
                
            }, title: "\(fighter.isIppon ? 0 : fighter.wazaari)")
            .buttonStyle(PointButtonStyle())
        }
        .foregroundStyle(fighter.color.primary)
    }
}

#Preview {
    FighterView(fighter: Fighter(color: .red))
}
