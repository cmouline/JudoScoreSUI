//
//  BottomButtonType.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 14/10/2024.
//

import SwiftUI

enum BottomButtonType: Equatable {
    case none
    case hansokumake
    case kiken
    case shido
    case osaekomi
    case fighter(for: Fighter)

    var title: String {
        switch self {
        case .none:
            return ""
        case .hansokumake:
            return "HM"
        case .kiken:
            return "KIKEN"
        case .shido:
            return "SHIDO"
        case .osaekomi:
            return "OSAEKOMI"
        case .fighter(let fighter):
            return fighter.color.rawValue
        }
    }
    
    var textColor: Color {
        switch self {
        case .none:
            return .gray
        case .hansokumake:
            return .jSred
        case .kiken:
            return .purple
        case .shido:
            return .jSyellow
        case .osaekomi:
            return .purple
        case .fighter(let fighter):
            return fighter.color.secondary
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .fighter(let fighter):
            return fighter.color.primary
        default :
            return .black
        }
    }
    
    var borderColor: Color {
        switch self {
        case .osaekomi:
            return .purple
        case .fighter:
            return self.backgroundColor
        default:
            return self.textColor
        }
    }
}

