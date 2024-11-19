//
//  Fighter.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 02/10/2024.
//

import SwiftUI

@Observable class Fighter {
    
    enum FighterColor: String {
        case red
        case white
        case blue
        
        var primary: Color {
            switch self {
            case .red:
                return .jSred
            case .white:
                return .white
            case .blue:
                return .jsLightBlue
            }
        }

        var secondary: Color {
            switch self {
            case .red, .blue:
                return .white
            case .white:
                return .black
            }
        }
    }
    
    var color: FighterColor
    var name: String = ""
    var wazaari = 0
    var isIppon = false
    var shido = 0
    var isHansokumake = false
    var isForfeit = false
    
    var ipponString: String {
        isIppon ? "1" : ""
    }
    
    init(color: FighterColor) {
        self.color = color
        self.name = color.rawValue
    }
    
    func reset() {
        wazaari = 0
        isIppon = false
        
        shido = 0
        isHansokumake = false
        isForfeit = false
        name = color.rawValue//.localized()
    }
    
    func addShido() {
        shido += 1
        isHansokumake = shido == 3 ? true : false
    }
    
    func removeShido() {
        if shido == 3 {
            isHansokumake = false
        }
        shido -= 1
    }
    
    func addWazaari() {
        
        guard wazaari < 2 else { return }
        
        wazaari += 1
        if wazaari == 2 {
            isIppon = true
        }
    }
    
    func removeWazaari() {
        
        guard wazaari > 0 else { return }
        
        wazaari -= 1
        isIppon = false
    }
}

extension Fighter: Equatable {
    
    static func == (lhs: Fighter, rhs: Fighter) -> Bool {
        return lhs.wazaari == rhs.wazaari &&
        lhs.shido == rhs.shido &&
        lhs.isIppon == rhs.isIppon &&
        lhs.isForfeit == rhs.isForfeit &&
        lhs.isHansokumake == rhs.isHansokumake &&
        lhs.name == rhs.name &&
        lhs.color == rhs.color
    }
}
