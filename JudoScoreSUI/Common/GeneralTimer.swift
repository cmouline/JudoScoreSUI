//
//  GeneralTimer.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 19/11/2024.
//

import SwiftUI
import Combine

@Observable class GeneralTimer {
    
    static let shared = GeneralTimer()
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

}
