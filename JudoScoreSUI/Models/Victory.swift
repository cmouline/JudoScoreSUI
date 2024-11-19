//
//  Victory.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 14/10/2024.
//

import SwiftUI

enum Victory {
    case ippon
    case wazaari
    case hansokumake
    case forfeit
    case decisionHikiwake
    case decisionFighter
    case equal
}

struct VictoryData {
    var winnerName: String
    var winnerColor: Color
    var loserColor: Color?
    var victory: Victory
    
    init(winnerIs winnerName: String = "",
         winnerColor: Color,
         loserColor: Color? = nil,
         by victoryType: Victory) {
        
        self.winnerName = winnerName
        self.winnerColor = winnerColor
        self.loserColor = loserColor
        self.victory = victoryType
    }
    
    func displayVictoryText() -> String {
        switch victory {
        case .ippon,
             .wazaari,
             .decisionFighter,
             .forfeit,
             .hansokumake:
            return "Winner \(winnerName)"
        case .decisionHikiwake:
            return "Hikiwake"
        case .equal:
            return "Golden score"
        }
    }
}
