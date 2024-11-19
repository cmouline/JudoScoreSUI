//
//  BottomBarView.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 03/10/2024.
//

import SwiftUI

struct BottomBarView: View {
    
    @Environment(Fight.self) private var fight
    
    @State var selectedButton: BottomButtonType = .none

    var body: some View {
        
        ZStack {
            
            HStack(spacing: 2) {
                
                BottomBarButton(tapAction: { selectedButton = selectedButton == .hansokumake ? .none : .hansokumake },
                                isSelected: selectedButton == .hansokumake,
                                buttonType: .hansokumake)
                
                BottomBarButton(tapAction: { selectedButton = selectedButton == .kiken ? .none : .kiken },
                                isSelected: selectedButton == .kiken,
                                buttonType: .kiken)
                
                BottomBarButton(tapAction: { selectedButton = selectedButton == .shido ? .none : .shido },
                                isSelected: selectedButton == .shido,
                                buttonType: .shido)
                
                VStack(spacing: 2) {
                    
                    BottomBarButton(tapAction: { addPenaltyTo(fighter: fight.fighter1) },
                                    doubleTapAction: { removePenaltyTo(fighter: fight.fighter1) },
                                    isSelected: selectedButton != .none,
                                    buttonType: .fighter(for: fight.fighter1))
                    
                    BottomBarButton(tapAction: { addPenaltyTo(fighter: fight.fighter2) },
                                    doubleTapAction: { removePenaltyTo(fighter: fight.fighter2) },
                                    isSelected: selectedButton != .none,
                                    buttonType: .fighter(for: fight.fighter2))

                }
                
                BottomBarButton(tapAction: {
                    
                    if !fight.isOsaekomiTimerRunning && fight.osaekomiTimerValue > 0 {
                        fight.osaekomiTimerValue = 0
                        selectedButton = .none
                    } else {
                        fight.isOsaekomiTimerRunning.toggle()
                        selectedButton = .osaekomi
                    }
                    
                },
                                isSelected: selectedButton == .osaekomi,
                                buttonType: .osaekomi)

                .onReceive(fight.generalTimer.timer) { _ in
                    
                    if fight.osaekomiTimerValue >= 0 && fight.osaekomiTimerValue < 20 && fight.isOsaekomiTimerRunning {
                        
                        fight.osaekomiTimerValue += 1
                        if let fighter = fight.selectedFighter, fight.osaekomiTimerValue == 10 {
                            fighter.addWazaari()
                        } else if let fighter = fight.selectedFighter, fight.osaekomiTimerValue == 20 {
                            fighter.isIppon = true
                        }
                        if let fighter = fight.selectedFighter, fighter.isIppon {
                            fight.isOsaekomiTimerRunning = false
                        }
                    }
                }
            }
            
            VictoryView()
                .hidden(fight.victoryData == nil || fight.victoryData?.victory == .equal)

        }
    }
    
    func addPenaltyTo(fighter: Fighter) {
        if selectedButton == .shido && fighter.shido < 3 {
            fighter.addShido()
        } else if selectedButton == .hansokumake {
            fighter.isHansokumake = true
        } else if selectedButton == .kiken {
            fighter.isForfeit = true
        } else if selectedButton == .osaekomi {
            fight.selectedFighter = fighter
        }
    }
    
    func removePenaltyTo(fighter: Fighter) {
        if selectedButton == .shido && fighter.shido > 0 {
            fighter.removeShido()
        } else if selectedButton == .hansokumake {
            fighter.isHansokumake = false
        } else if selectedButton == .kiken {
            fighter.isForfeit = false
        }
    }
}

#Preview {
    @Previewable var fight = Fight(fighter1: Fighter(color: .red),
                                   fighter2: Fighter(color: .white))
    BottomBarView()
        .environment(fight)
}
