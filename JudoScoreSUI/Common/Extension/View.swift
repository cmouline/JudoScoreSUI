//
//  View.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 10/10/2024.
//

import SwiftUI

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
