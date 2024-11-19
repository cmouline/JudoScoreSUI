//
//  Fight.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 02/10/2024.
//

import SwiftUI

@Observable class Fight {
    
    var generalTimer: GeneralTimer = GeneralTimer()
    
    /// Main timer values
    var baseTimer = 240
    var mainTimerRemainingTime = 240
    var isMainTimerRunning = false
    
    /// Osaekomi timer values
    var osaekomiTimerValue = 0
    var isOsaekomiTimerRunning = false

    var selectedFighter: Fighter?
    
    var fighter1: Fighter
    var fighter2: Fighter
    var victoryData: VictoryData? = nil
    var isVictoryPossible: Bool {
        return fighter1.isHansokumake
            || fighter2.isHansokumake
            || fighter1.isForfeit
            || fighter2.isForfeit
            || fighter1.isIppon
            || fighter2.isIppon
            || mainTimerRemainingTime == 0
    }
    
    init(fighter1: Fighter, fighter2: Fighter) {
        self.fighter1 = fighter1
        self.fighter2 = fighter2
    }
    
    func resetFight() {
        
        fighter1.reset()
        fighter2.reset()
        victoryData = nil
        selectedFighter = nil
        
        mainTimerRemainingTime = baseTimer
        isMainTimerRunning = false
        
        osaekomiTimerValue = 0
        isOsaekomiTimerRunning = false
    }
        
    func setWinner() {
        var data: VictoryData
        
        if fighter1.isHansokumake && !fighter2.isHansokumake {
            data = VictoryData(winnerIs: fighter2.name,
                               winnerColor: fighter2.color.primary,
                               loserColor: fighter1.color.primary,
                               by: .hansokumake)
        } else if fighter2.isHansokumake && !fighter1.isHansokumake {
            data = VictoryData(winnerIs: fighter1.name,
                               winnerColor: fighter1.color.primary,
                               loserColor: fighter2.color.primary,
                               by: .hansokumake)
        } else if fighter2.isHansokumake && fighter1.isHansokumake {
            data = VictoryData(winnerIs: "",
                               winnerColor: .purple,
                               by: .decisionHikiwake)
        } else if fighter1.isForfeit && !fighter2.isForfeit {
            data = VictoryData(winnerIs: fighter2.name,
                               winnerColor: fighter2.color.primary,
                               loserColor: fighter1.color.primary,
                               by: .forfeit)
        } else if fighter2.isForfeit && !fighter1.isForfeit {
            data = VictoryData(winnerIs: fighter1.name,
                               winnerColor: fighter1.color.primary,
                               loserColor: fighter2.color.primary,
                               by: .forfeit)
        } else if fighter2.isForfeit && fighter1.isForfeit {
            data = VictoryData(winnerIs: "",
                               winnerColor: .purple,
                               by: .decisionHikiwake)
        } else if fighter1.isIppon {
            data = VictoryData(winnerIs: fighter1.name,
                               winnerColor: fighter1.color.primary,
                               by: .ippon)
        } else if fighter2.isIppon {
            data = VictoryData(winnerIs: fighter2.name,
                               winnerColor: fighter2.color.primary,
                               by: .ippon)
        } else if fighter1.wazaari > fighter2.wazaari {
            data = VictoryData(winnerIs: fighter1.name,
                               winnerColor: fighter1.color.primary,
                               by: .wazaari)
        } else if fighter2.wazaari > fighter1.wazaari {
            data = VictoryData(winnerIs: fighter2.name,
                               winnerColor: fighter2.color.primary,
                               by: .wazaari)
        } else {
            data = VictoryData(winnerIs: "",
                               winnerColor: .purple,
                               by: .equal)
        }
        
        victoryData = data
    }
}

extension Fight: Equatable {
    
    static func == (lhs: Fight, rhs: Fight) -> Bool {
        return lhs.fighter1 == rhs.fighter1 && lhs.fighter2 == rhs.fighter2
    }
}
