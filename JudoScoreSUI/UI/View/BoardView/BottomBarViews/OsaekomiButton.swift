//
//  OsaekomiButton.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 10/10/2024.
//

import SwiftUI

struct OsaekomiButton: View {
    
    @State var selectedFighter: Fighter?

    var tapAction: (() -> Void)
    
    @State private var osaekomiTimerValue = 0
    @State private var isOsaekomiTimerRunning = false
    let osaekomiTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        Button(action: {
            
            tapAction()
            if !isOsaekomiTimerRunning && osaekomiTimerValue > 0 {
                osaekomiTimerValue = 0
            } else {
                isOsaekomiTimerRunning.toggle()
            }
            
        }, label: {
            Text(osaekomiTimerValue == 0 ? "OSAEKOMI" : "\(osaekomiTimerValue)")
        })
        .font(.custom("LemonMilkLight", size: osaekomiTimerValue > 0 ? 50 : 20))
        .foregroundStyle(selectedFighter != nil ? selectedFighter!.color.primary : .gray)
        .onReceive(osaekomiTimer) { _ in
            if osaekomiTimerValue >= 0 && osaekomiTimerValue < 20 && isOsaekomiTimerRunning {
                osaekomiTimerValue += 1
                if let fighter = selectedFighter, osaekomiTimerValue == 10 {
                    fighter.addWazaari()
                } else if let fighter = selectedFighter, osaekomiTimerValue == 20 {
                    fighter.isIppon = true
                }
                if let fighter = selectedFighter, fighter.isIppon {
                    isOsaekomiTimerRunning = false
                }
            }
        }
    }
}
